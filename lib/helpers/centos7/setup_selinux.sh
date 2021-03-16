clean_selinux_modules_files() {
  rm /tmp/local.{te,mod,pp}
}
# Allow httpd to create gnupg socket file
setup_gnupg_socket_policy() {
  cat << EOF > /tmp/local.te
module local 1.0;

require {
	type httpd_t;
	type httpd_sys_rw_content_t;
	class sock_file create;
}

#============= httpd_t ==============
allow httpd_t httpd_sys_rw_content_t:sock_file create;
EOF

  checkmodule -M -m -o /tmp/local.mod /tmp/local.te
  semodule_package -o /tmp/local.pp -m /tmp/local.mod
  semodule -i /tmp/local.pp
  clean_selinux_modules_files
}

setup_selinux() {
  local selinux_status

  banner "Setting up selinux permissions. This may take a little while..."
  if [ -x /usr/sbin/sestatus ]; then
    selinux_status="$(sestatus |grep 'SELinux status' | awk '{print $3}')"
    if [ "$selinux_status" == "enabled" ]; then
      semanage boolean -m httpd_can_network_connect -1
      semanage boolean -m httpd_can_network_connect_db -1
      semanage fcontext -a -t httpd_sys_rw_content_t "$PASSBOLT_BASE_DIR(/.*)?"
      restorecon -R "$PASSBOLT_BASE_DIR"
      semanage fcontext -a -t httpd_sys_rw_content_t "$GNUPG_HOME(/.*)?"
      restorecon -R "$GNUPG_HOME"
      setup_gnupg_socket_policy
    fi
  fi
}

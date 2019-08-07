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
    fi
  fi
}


setup_yum() {
  install_packages yum-utils epel-release
  if ! yum list installed | grep remi-release; then
    yum -y install "$REMI_PHP_URL"
  fi
  yum-config-manager --enable "$REMI_PHP_VERSION"
}

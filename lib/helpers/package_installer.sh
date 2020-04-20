__installer_command() {
  local _installer=''
  case $OS in
    'debian'|'ubuntu')
      _installer=apt-get
      ;;
    'centos')
      _installer=yum
      ;;
    'redhat')
      _installer=yum
      ;;
    *)
      die "Unsupported OS"
      ;;
  esac

  echo "$_installer"
}


install_packages() {
  local installer
  local packages="$1"

  installer="$(__installer_command)"
  if [ "$installer" == "apt-get" ]; then
    "$installer" update
  fi

  "$installer" -y install $packages
}

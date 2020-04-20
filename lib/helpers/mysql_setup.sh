# require _mysql_db_installer.sh
# require helpers/utils/messages.sh
# require ../initializers/_variable_accessor.sh
# require service_enabler.sh
# require package_installer.sh
mysql_setup() {
  local mariadb_package="${1:-mariadb-server}"
  local mariadb_service="${2:-mariadb}"

  if [[ "$(__config_get 'mariadb_local_installation')" == true ]]; then
    banner 'Installing mariadb...'
    install_packages "$mariadb_package"
    enable_service "$mariadb_service"
    __install_db 'mariadb_root_password' 'mariadb_user' 'mariadb_passbolt_password' 'mariadb_name'
  else
    banner 'Using remote or custom database installation'
  fi
}

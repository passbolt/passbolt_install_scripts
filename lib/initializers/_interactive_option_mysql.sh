# require _variable_accessor.sh
# require _interactive_option_password.sh
# require /helpers/utils/messages.sh
__prompt_mariadb_credentials(){
  local _config_root_pw="$1"
  local _config_user="$2"
  local _config_pw="$3"
  local _config_db="$4"
  local _config_local_db="$5"
  local _config_remote_db="$6"
  local _mariadb_user
  local _mariadb_name
  local options=("yes" "no")

  if [[ -z "$(__config_get "$_config_local_db")" && \
        -z "$(__config_get "$_config_remote_db")" ]]; then
    banner "Do you want to install a local mariadb server on this machine?"
    select opt in "${options[@]}"; do
      case $opt in
        "yes")
          __config_set "$_config_local_db" true
          break
          ;;
        "no")
          __config_set "$_config_local_db" false
          return
          ;;
        *)
          echo "Please select (1) or (2) to continue"
          ;;
      esac
    done
  fi

  if [[ "$(__config_get "$_config_local_db")" == 'true' ]]; then
    if [[ -z "$(__config_get "$_config_root_pw")" ]]; then
      banner "Please enter a new password for the root database user:"
      __password_validation "MariaDB Root Password" "$_config_root_pw"
    fi

    if [[ -z "$(__config_get "$_config_user")" ]]; then
      banner "Please enter a name for the passbolt database username"
      read -r -p "Passbolt database user name:" _mariadb_user
      __config_set "$_config_user" "$_mariadb_user"
    fi

    if [[ -z "$(__config_get "$_config_pw")" ]]; then
      banner "Please enter a new password for the mysql passbolt user"
      __password_validation "MariaDB passbolt user password" "$_config_pw"
    fi

    if [[ -z "$(__config_get "$_config_db")" ]]; then
      banner "Please enter a name for the passbolt database:"
      read -r -p "Passbolt database name:" _mariadb_name
      __config_set "$_config_db" "$_mariadb_name"
    fi
  fi
}

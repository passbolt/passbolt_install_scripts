# require ../initializers/_variable_accessor.sh
# require ../helpers/utils/errors.sh
__validate_cli_options() {
  local message_mysql="Wrong parameters. Check your database parameters"
  local message_ssl="Wrong parameters. Check your SSL parameters"

  if [[ "$(__config_get 'mariadb_local_installation')" && \
        "$(__config_get 'mariadb_remote_installation')" ]]; then
    die "$message_mysql"
  fi

  if [[ ( "$(__config_get 'ssl_manual')" && "$(__config_get 'ssl_none')" ) || \
        ( "$(__config_get 'ssl_auto')" && "$(__config_get 'ssl_none')" ) || \
        ( "$(__config_get 'ssl_auto')" && "$(__config_get 'ssl_manual')" ) ]]; then
    die "$message_ssl"
  fi

  if [[ ( -n "$(__config_get 'ssl_certificate')" || \
    -n "$(__config_get 'ssl_privkey')" ) && "$(__config_get 'ssl_method')" == 'none' ]]; then
    die "$message_ssl"
  fi

  if [[ "$(__config_get 'ssl_auto')" == true && "$(__config_get 'ssl_method')" == 'none' ]]; then
    die "$message_ssl"
  fi


  if [[ ( -n "$(__config_get 'ssl_certificate')" || \
    -n "$(__config_get 'ssl_privkey')" ) && "$(__config_get 'ssl_auto')" == true ]]; then
    die "$message_ssl"
  fi

  if [[ (-z "$(__config_get 'ssl_certificate')" && -n "$(__config_get 'ssl_privkey')") || \
    (-n "$(__config_get 'ssl_certificate')" && -z "$(__config_get 'ssl_privkey')") ]]; then
    die "$message_ssl"
  fi
}

# require _variable_accessor.sh
# require /helpers/utils/errors.sh
# require /validators/_cli_option_validator
get_options(){
  local OPTIND=$OPTIND

  while getopts "ahnrec:d:k:m:u:p:P:H:" opt; do
    case $opt in
      a)
        __config_set 'ssl_auto' true
        ;;
      c)
        __config_set 'ssl_certificate' "$OPTARG"
        __config_set 'ssl_manual' true
        ;;
      d)
        __config_set 'mariadb_name' "$OPTARG"
        __config_set 'mariadb_local_installation' true
        ;;
      e)
        __config_set 'haveged_install' true
        ;;
      h)
        disclaimer
        usage
        exit 0
        ;;
      k)
        __config_set 'ssl_privkey' "$OPTARG"
        __config_set 'ssl_manual' true
        ;;
      m)
        __config_set 'letsencrypt_email' "$OPTARG"
        __config_set 'ssl_auto' true
        ;;
      n)
        __config_set 'ssl_none' true
        ;;
      p)
        __config_set 'mariadb_passbolt_password' "$OPTARG"
        __config_set 'mariadb_local_installation' true
        ;;
      r)
        __config_set 'mariadb_remote_installation' true
        ;;
      u)
        __config_set 'mariadb_user' "$OPTARG"
        __config_set 'mariadb_local_installation' true
        ;;
      P)
        __config_set 'mariadb_root_password' "$OPTARG"
        __config_set 'mariadb_local_installation' true
        ;;
      H)
        __config_set 'passbolt_hostname' "$OPTARG"
        ;;
      *)
        die "Invalid option"
        ;;
    esac
  done

  __validate_cli_options
}

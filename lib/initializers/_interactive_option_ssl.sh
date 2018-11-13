# require _variable_accessor.sh
# require /helpers/utils/messages.sh
__prompt_ssl_paths(){
  local _config_ssl_cert="$1"
  local _config_ssl_key="$2"
  local _ssl_cert
  local _ssl_key

  if [[ -z "$(__config_get "$_config_ssl_cert")" ]]; then
    read -rp "Enter the path to the SSL certificate: " _ssl_cert
    while [[ "$(__validate_ssl_paths "$_ssl_cert")" == 'false' ]]; do
      banner "Please introduce a valid path to your ssl certificate"
      read -rp "Enter the path to the SSL certificate: " _ssl_cert
    done
    __config_set "$_config_ssl_cert" "$_ssl_cert"
  fi

  if [[ -z "$(__config_get "$_config_ssl_key")" ]]; then
    read -rp "Enter the path to the SSL privkey: " _ssl_key
    while [[ "$(__validate_ssl_paths "$_ssl_key")" == 'false' ]]; do
      banner "Please introduce a valid path to your ssl key file"
      read -rp "Enter the path to the SSL key: " _ssl_key
    done
    __config_set "$_config_ssl_key" "$_ssl_key"
  fi
}

__prompt_lets_encrypt_details() {
  local _config_ssl_email="$1"
  local _ssl_email

  if [[ -z "$(__config_get "$_config_ssl_email")" ]]; then
    read -rp "Enter a email address to register with Let's Encrypt: " _ssl_email
    __config_set "$_config_ssl_email" "$_ssl_email"
  fi
}

__prompt_ssl(){
  local _options=("manual" "auto" "none")
  local _config_ssl_auto="$1"
  local _config_ssl_manual="$2"
  local _config_ssl_none="$3"
  local _config_ssl_cert="$4"
  local _config_ssl_key="$5"
  local _config_ssl_email="$6"

  if [[ -z "$(__config_get "$_config_ssl_auto")" && \
        -z "$(__config_get "$_config_ssl_manual")" && \
        -z "$(__config_get "$_config_ssl_none")" ]]; then
    banner "Setting up SSL...
    Do you want to setup a SSL certificate and enable HTTPS now?
    - manual: Prompts for the path of user uploaded ssl certificates and set up nginx
    - auto:   Will issue a free SSL certificate with https://www.letencrypt.org and set up nginx
    - none:   Do not setup HTTPS at all"
    select opt in "${_options[@]}"; do
      case $opt in
        "manual")
          __config_set "$_config_ssl_manual" true
          break
          ;;
        "auto")
          __config_set "$_config_ssl_auto" true
          break
          ;;
        "none")
          __config_set "$_config_ssl_none" true
          return
          break
          ;;
        *)
          echo "Wrong option, please choose (1) manual, (2) auto or (3) none"
        ;;
      esac
    done
  fi

  if [[ "$(__config_get "$_config_ssl_manual")" == 'true' ]]; then
    __prompt_ssl_paths "$_config_ssl_cert" "$_config_ssl_key"
  fi

  if [[ "$(__config_get "$_config_ssl_auto")" == 'true' ]]; then
    __prompt_lets_encrypt_details "$_config_ssl_email"
  fi
}

# require utils/messages.sh
# require service_enabler.sh
# require _setup_ssl.sh
__nginx_config(){
  local source_template="$1"
  local nginx_config_file="$2"
  local _config_passbolt_host="$3"

  if [ ! -f "$nginx_config_file" ]; then
    cp "$source_template" "$nginx_config_file"
    sed -i s:_SERVER_NAME_:"$(__config_get "$_config_passbolt_host")": "$nginx_config_file"
  fi
}

__ssl_substitutions(){
    sed -i s:_NGINX_CERT_FILE_:"$SSL_CERT_PATH": "$NGINX_SITE_DIR/passbolt_ssl.conf"
    sed -i s:_NGINX_KEY_FILE_:"$SSL_KEY_PATH": "$NGINX_SITE_DIR/passbolt_ssl.conf"
}

setup_nginx(){
  local passbolt_domain

  passbolt_domain=$(__config_get 'passbolt_hostname')
  banner "Setting up nginx..."

  __nginx_config "$script_directory/conf/nginx/passbolt.conf" "$NGINX_SITE_DIR/passbolt.conf" 'passbolt_hostname'
  enable_service 'nginx'

  if [[ "$(__config_get 'ssl_auto')" == 'true' ]]; then
    if __setup_letsencrypt 'passbolt_hostname' 'letsencrypt_email'; then
      __nginx_config "$script_directory/conf/nginx/passbolt_ssl.conf" "$NGINX_SITE_DIR/passbolt_ssl.conf" 'passbolt_hostname'
      ln -s "$LETSENCRYPT_LIVE_DIR/$passbolt_domain/cert.pem" "$SSL_CERT_PATH"
      ln -s "$LETSENCRYPT_LIVE_DIR/$passbolt_domain/privkey.pem" "$SSL_KEY_PATH"
      __ssl_substitutions
      enable_service 'nginx'
    else
      banner "WARNING: Unable to setup SSL using lets encrypt. Please check the install.log"
    fi
  fi

  if [[ "$(__config_get 'ssl_manual')" == 'true' ]]; then
    __nginx_config "$script_directory/conf/nginx/passbolt_ssl.conf" "$NGINX_SITE_DIR/passbolt_ssl.conf" 'passbolt_hostname'
    __copy_ssl_certs 'ssl_certificate' 'ssl_privkey'
    __ssl_substitutions
    enable_service 'nginx'
  fi
}

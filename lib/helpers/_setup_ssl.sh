__copy_ssl_certs() {
  local _config_ssl_cert="$1"
  local _config_ssl_key="$2"

  if [[ -e "$SSL_CERT_PATH" ]]; then
    mv "$SSL_CERT_PATH"{,.orig}
  fi

  if [ -e "$SSL_KEY_PATH" ]; then
    mv "$SSL_KEY_PATH"{,.orig}
  fi

  if [[ -f "$(__config_get "$_config_ssl_cert")"  && -f "$(__config_get "$_config_ssl_key")" ]]; then
    cp "$(__config_get "$_config_ssl_cert")" "$SSL_CERT_PATH"
    cp "$(__config_get "$_config_ssl_key")" "$SSL_KEY_PATH"
  else
    mv "$NGINX_SITE_DIR"/passbolt_ssl.conf{,.orig}
    banner "Unable to locate SSL certificate files."
  fi
}

__setup_letsencrypt() {
  local _config_passbolt_host="$1"
  local _config_email="$2"

  certbot certonly --authenticator webroot \
    -n \
    -w "$PASSBOLT_BASE_DIR"/webroot \
    -d "$(__config_get "$_config_passbolt_host")" \
    -m "$(__config_get "$_config_email")" \
    --agree-tos
}

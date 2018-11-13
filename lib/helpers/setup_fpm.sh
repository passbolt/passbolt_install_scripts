# require service_enabler.sh
setup_fpm(){
  if [ -f "$FPM_WWW_POOL" ]; then
    cp "$FPM_WWW_POOL"{,.orig}
  fi

  cp "$script_directory/conf/php/www.conf" "$FPM_WWW_POOL"
  sed -i s:_WWW_USER_:"$WWW_USER": "$FPM_WWW_POOL"

  enable_service "$FPM_SERVICE"
}

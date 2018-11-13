install_gpg_extension() {
  if [ "$(php -m |grep gnupg)" != "gnupg" ]; then
    pecl install gnupg
    echo "extension=gnupg.so" > "$PHP_EXT_DIR"/gnupg.ini
  fi
}

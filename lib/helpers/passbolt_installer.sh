# require setup_composer.sh
passbolt_install() {

  if [ -d "$PASSBOLT_BASE_DIR" ]; then
    cd "$PASSBOLT_BASE_DIR" && git pull && cd -
  else
    git clone --depth 1 --progress -b "$PASSBOLT_BRANCH" "$PASSBOLT_REPO" "$PASSBOLT_BASE_DIR"
  fi
  if [ ! -f "$PASSBOLT_BASE_DIR/config/app.php" ]; then
    cp "$PASSBOLT_BASE_DIR"/config/{app.default.php,app.php}
  fi

  chown -R "$WWW_USER":"$WWW_USER" "$PASSBOLT_BASE_DIR"
  composer_install "$WWW_USER"
  chmod +w -R "$PASSBOLT_BASE_DIR/tmp"
  chmod +w "$PASSBOLT_BASE_DIR/webroot/img/public"
}

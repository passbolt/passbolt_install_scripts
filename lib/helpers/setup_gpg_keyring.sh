setup_gpg_keyring() {
  if [ ! -d "$GNUPG_HOME" ]; then
    mkdir -p "$GNUPG_HOME"
    chown -R "$WWW_USER":"$WWW_USER" "$GNUPG_HOME"
    su -c "gpg --list-keys" -s /bin/bash "$WWW_USER"
  fi
}

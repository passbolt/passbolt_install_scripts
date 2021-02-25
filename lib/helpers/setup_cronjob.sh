cron_job() {
  local process_email="$PASSBOLT_BASE_DIR/bin/cron"

  if [ ! -f "$CRONTAB_DIR"/$WWW_USER ] || [ ! "$(grep -q "$process_email" "$CRONTAB_DIR/$WWW_USER" )" ]; then
    echo "* * * * * $process_email" | crontab -u "$WWW_USER" -
  fi
}

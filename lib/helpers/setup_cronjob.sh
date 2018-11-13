cron_job() {
  local process_email="$PASSBOLT_BASE_DIR/bin/cake EmailQueue.sender"

  if [ ! -d "$CRONTAB_DIR" ] || [ ! "$(grep "$process_email" "$CRONTAB_DIR"/* )" ]; then
    echo "* * * * * $process_email" | crontab -u "$WWW_USER" -
  fi
}

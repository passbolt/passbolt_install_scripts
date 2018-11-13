enable_service() {
  systemctl enable "$1"
  systemctl restart "$1"
}

stop_service() {
  systemctl stop "$1"
}

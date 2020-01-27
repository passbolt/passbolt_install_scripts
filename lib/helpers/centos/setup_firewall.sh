setup_firewall() {
  local zone=public
  local services=(http, https)
  banner "Opening ports 80 and 443 on firewall"

  for i in "${services[@]}"; do
    firewall-cmd --permanent --zone="$zone" --add-service="$i"
  done

  enable_service firewalld
}

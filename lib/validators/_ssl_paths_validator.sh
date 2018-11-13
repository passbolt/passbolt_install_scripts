# require _variable_accessor.sh

__validate_ssl_paths() {
  local _cert_path="$1"

  if [[ -f "$_cert_path" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

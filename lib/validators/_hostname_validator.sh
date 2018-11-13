# require _variable_accessor.sh

__validate_hostname() {
  local _passbolt_hostname="$1"

  if ! [[ "$_passbolt_hostname" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ || \
          "$_passbolt_hostname" =~ ^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$ ]]; then
    echo "false"
  else
    echo "true"
  fi
}

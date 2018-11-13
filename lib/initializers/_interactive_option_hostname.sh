# require _variable_accessor.sh
# require /helpers/utils/messages.sh
__prompt_passbolt_hostname() {
  local _passbolt_hostname
  local _host_config_key="$1"

  _host_config_key="$1"
  if [[ -z "$(__config_get "$_host_config_key")" ]]; then
    banner "Setting hostname...
    Please enter the domain name under which passbolt will run.
    Note this hostname will be used as server_name for nginx
    and as the domain name to register a SSL certificate with
    let's encrypt.
    If you don't have a domain name and you do not plan to use
    let's encrypt please enter the ip address to access this machine"
    read -r -p "Hostname:" _passbolt_hostname
    while [[ "$(__validate_hostname "$_passbolt_hostname")" == 'false' ]]; do
      banner "Please introduce a valid hostname. Valid hostnames are either
      IPv4 addresses or fully qualified domain names"
      read -r -p "Hostname:" _passbolt_hostname
    done
    __config_set "$_host_config_key" "$_passbolt_hostname"
  fi
}

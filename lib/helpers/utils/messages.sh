# require /initializers/_variable_accessor.sh
banner(){
  local message=$1
  local len_message=${#message}
  local len=$((len_message < 80 ? len_message : 80 ))

  printf "%0.s=" $(seq 1 "$len")
  printf "\\n"
  printf "%b" "$message" |fold
  printf "\\n"
  printf "%0.s=" $(seq 1 "$len")
  printf "\\n"
}

installation_complete() {
  local protocol='https'

  if [[ "$(__config_get 'ssl_none')" ]]; then
    protocol='http'
  fi

  banner "Installation is almost complete. Please point your browser to
  $protocol://$(__config_get 'passbolt_hostname') to complete the process"
}

disclaimer() {
  cat <<-'EOF'
================================================================
           ____                  __          ____
          / __ \____  _____ ____/ /_  ____  / / /_
         / /_/ / __ `/ ___/ ___/ __ \/ __ \/ / __/
        / ____/ /_/ (__  |__  ) /_/ / /_/ / / /_
       /_/    \__,_/____/____/_,___/\____/_/\__/

      The open source password manager for teams
      (c) 2020 Passbolt SA
      https://www.passbolt.com
================================================================
IMPORTANT NOTE: This installation scripts are for use only
on FRESH installed debian >= 9.0 | ubuntu 18.04 | CentOS >= 7.0
================================================================
EOF
}

# require _variable_accessor.sh
__password_validation() {
  local message="$1"
  local pw_config="$2"
  local _pw="$UNDEFINED"
  local _pw_verify=''

  while [[ "$_pw" != "$_pw_verify" ]]; do
    read -rs -p "$message:" _pw
    if [[ -z "$_pw" ]]; then
      echo "Dont use blank passwords"
      _pw="$UNDEFINED"
      continue
    fi
    echo ""
    read -rs -p "$message (verify):" _pw_verify
    echo ""
    if [[ "$_pw" != "$_pw_verify" ]]; then
      echo "Passwords mismatch, please try again."
    fi
  done
    __config_set "$pw_config" "$_pw"
}

__config_data() {
  declare -gA config
}
__config_set() {
  config[$1]="$2"
  return $?
}

__config_get() {
  if [[ -z "${config[$1]+'test'}" ]]; then
    echo ""
  else
    echo "${config[$1]}"
  fi
}

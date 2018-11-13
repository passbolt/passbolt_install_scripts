# require _os_version_validator.sh
# require _os_permissions_validator.sh
__compare_versions() {
  local _current="$1"
  local _supported="$2"

  if [ "$_supported" != "$(printf "%b" "$_current\\n$_supported" | sort -V | head -n1)" ];then
    die "Your OS Version is not supported."
  fi
}

__validate_os_version() {
  local current="$1"
  local supported="$2"

  if [ "$current" != "$supported" ]; then
    __compare_versions "$current" "$supported"
  fi
}

validate_os() {
  local os="$1"
  __validate_os_permissions
  if [ "$os" == 'debian' ] || [ "$os" == 'ubuntu' ]; then
    __validate_os_version "$(cat "$OS_VERSION_FILE")" "$OS_SUPPORTED_VERSION"
  else
    __validate_os_version "$(awk '{print $3}' < "$OS_VERSION_FILE")" "$OS_SUPPORTED_VERSION"
  fi
}

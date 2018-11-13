# require _os_version_validator.sh
# require _os_permissions_validator.sh
validate_os() {
  __validate_os_permissions
  __validate_os_version "$(cat "$OS_VERSION_FILE")" "$OS_SUPPORTED_VERSION"
}

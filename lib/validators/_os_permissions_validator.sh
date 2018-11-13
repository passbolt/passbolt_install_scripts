# require ../helpers/utils/errors.sh
__validate_os_permissions() {
  if [[ "$EUID" != "0" ]]; then
    die "This script must be run with root permissions. Try using sudo $PROGNAME"
  fi
}

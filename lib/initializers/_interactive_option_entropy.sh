# require _variable_accessor.sh
# require /helpers/utils/messages.sh
__prompt_entropy_check(){
  local options=("yes" "no")
  local _config_key_haveged

  _config_key_haveged="$1"
  if [[ -z "$(__config_get "$_config_key_haveged")" ]]; then
    banner "On virtualized environments GnuPG happen to find not enough entropy
    to generate a key. Therefore, Passbolt will not run properly.
    Do you want to install Haveged to speed up the entropy generation on
    your system? Please check https://help.passbolt.com/somepath"

    select opt in "${options[@]}"; do
      case $opt in
        "yes")
          __config_set haveged_install true
          break
          ;;
        "no")
          __config_set haveged_install false
          break
          ;;
        *)
          echo "Please choose (1) or (2) to continue"
          ;;
      esac
    done
  fi
}

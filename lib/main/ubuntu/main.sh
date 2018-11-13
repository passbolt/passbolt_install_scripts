main(){
  init_config
  get_options "$@"
  validate_os 'ubuntu'
  disclaimer
  interactive_prompter
  usermod -d "$WWW_USER_HOME" "$WWW_USER"
  banner 'Installing os dependencies...'
  install_packages "$(cat "$script_directory/conf/packages.txt")"
  mysql_setup
  setup_fpm
  setup_gpg_keyring
  passbolt_install
  setup_nginx
  setup_entropy
  cron_job
  installation_complete
}

main "$@" 2>&1 | tee -a install.log

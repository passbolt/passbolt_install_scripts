main(){
  init_config
  get_options "$@"
  validate_os 'centos'
  disclaimer
  interactive_prompter
  banner 'Installing os dependencies...'
  setup_yum
  install_packages "$(cat "$script_directory/conf/packages.txt")"
  mysql_setup
  install_gpg_extension
  setup_fpm
  setup_gpg_keyring
  passbolt_install
  setup_nginx
  setup_entropy
  cron_job
  setup_selinux
  installation_complete
}

main "$@" 2>&1 | tee -a install.log

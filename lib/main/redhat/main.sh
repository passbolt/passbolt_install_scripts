main(){
  init_config
  get_options "$@"
  validate_os 'redhat'
  disclaimer
  interactive_prompter
  banner 'Installing os dependencies...'
  setup_yum 'redhat'
  install_packages "$(cat "$script_directory/conf/packages.txt")"
  activate_scl
  mysql_setup
  install_gpg_extension
  setup_fpm 'rh-php73-php-fpm'
  setup_gpg_keyring
  passbolt_install
  setup_firewall
  setup_selinux
  setup_nginx 'rh-nginx116-nginx'
  setup_entropy
  cron_job
  installation_complete
}

main "$@" 2>&1 | tee -a install.log

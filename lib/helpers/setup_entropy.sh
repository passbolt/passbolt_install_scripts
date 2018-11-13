# require package_installer.sh
# require service_enabler.sh
setup_entropy(){
  if [[ "$(__config_get 'haveged_install')" == true ]]; then
    install_packages haveged
    enable_service haveged
  fi
}

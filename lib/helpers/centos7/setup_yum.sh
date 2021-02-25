setup_yum() {
  local os="${1:-centos}"
  case $os in
    centos)
      install_packages "yum-utils epel-release $REMI_PHP_URL"
      if [ "$OS_SUPPORTED_VERSION" == "7.0" ]; then
        yum-config-manager --enable "$REMI_PHP_VERSION"
      else
        yum-config-manager --enable remi powertools baseos 
        dnf module enable php:"$REMI_PHP_VERSION"
      fi
      ;;
    redhat)
      enable_repos
      if ! yum list installed | grep epel-release; then
        install_packages "https://dl.fedoraproject.org/pub/epel/epel-release-latest-${RH_VERSION}.noarch.rpm"
      fi
  esac
}


enable_repos() {
  local repos=(
            "rhel-server-rhscl-${RH_VERSION}-rpms" 
            "rhel-${RH_VERSION}-server-extras-rpms" 
            "rhel-${RH_VERSION}-server-optional-rpms"
          )
  local enabled_repos=""

  enabled_repos="$(subscription-manager repos --list-enabled | grep 'Repo ID' | awk '{print $3}')"
  for repo in "${repos[@]}"; do
    if ! [[ "$enabled_repos" == *"$repo"* ]]; then
      subscription-manager repos --enable "$repo"
    fi
  done
}

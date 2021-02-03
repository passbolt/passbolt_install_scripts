setup_yum() {
  local os="${1:-centos}"
  case $os in
    centos)
      install_packages "yum-utils epel-release $REMI_PHP_URL"
      yum-config-manager --enable remi powertools baseos 
      dnf module enable php:"$REMI_PHP_VERSION"
      ;;
    redhat)
      enable_repos
      if ! yum list installed | grep epel-release; then
        install_packages "https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm"
      fi
  esac
}


enable_repos() {
  local repos=(rhel-server-rhscl-8-rpms rhel-8-server-extras-rpms rhel-8-server-optional-rpms)
  local enabled_repos=""

  enabled_repos="$(subscription-manager repos --list-enabled | grep 'Repo ID' | awk '{print $3}')"
  for repo in "${repos[@]}"; do
    if ! [[ "$enabled_repos" == *"$repo"* ]]; then
      subscription-manager repos --enable "$repo"
    fi
  done
}

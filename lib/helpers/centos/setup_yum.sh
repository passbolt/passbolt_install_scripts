setup_yum() {
  local os="${1:-centos}"
  case $os in
    centos)
      install_packages "yum-utils epel-release $REMI_PHP_URL"
      yum-config-manager --enable "$REMI_PHP_VERSION"
      ;;
    redhat)
      enable_repos
      if ! yum list installed | grep epel-release; then
        install_packages "https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
      fi
  esac
}


enable_repos() {
  local repos=(rhel-server-rhscl-7-rpms rhel-7-server-extras-rpms rhel-7-server-optional-rpms)
  local enabled_repos=""

  enabled_repos="$(subscription-manager repos --list-enabled | grep 'Repo ID' | awk '{print $3}')"
  for repo in "${repos[@]}"; do
    if ! [[ "$enabled_repos" == *"$repo"* ]]; then
      subscription-manager repos --enable "$repo"
    fi
  done
}

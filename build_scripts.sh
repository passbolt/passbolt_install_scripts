#!/usr/bin/env bash
#
# Small script that prepares install scripts for distribution
#
# - Concats all the parts in a single script under dist/<os>/
# - Creates a tarball under dist/tar/<os>
# - Checksums tarballs

set -euxo pipefail

build() {
  local output=dist/"$os"/passbolt_"$os"_installer.sh

  mkdir -p dist/"$os"/conf/{nginx,php}
  {
  cat templates/header.in
  cat conf/constants_common.sh
  cat "conf/$os/constants.sh"
  } >> "$output"

  for util in lib/helpers/utils/*.sh; do
    cat "$util" >> "$output";
  done

  for validator in lib/validators/*.sh; do
    cat "$validator" >> "$output";
  done

  for validator in lib/validators/*.sh; do
    cat "$validator" >> "$output";
  done

  for initializer in lib/initializers/*.sh; do
    cat "$initializer" >> "$output";
  done

  if [ "$os" == "centos" ]; then
    for helper in lib/helpers/"$os"/*.sh; do
      cat "$helper" >> "$output";
    done
  fi

  for helper in lib/helpers/*.sh; do
    cat "$helper" >> "$output";
  done

  cat "lib/main/$os/main.sh" >> "$output"

  chmod +x "$output"

  cp conf/nginx/*.conf "dist/$os/conf/nginx"
  cp conf/php/*.conf "dist/$os/conf/php"
  cp "conf/$os/packages.txt" "dist/$os/conf/packages.txt"
}

os="$1"
case $os in
  'debian')
    $0 clean
    build
    ;;
  'ubuntu')
    $0 clean
    build
    ;;
  'centos')
    $0 clean
    build
    ;;
  'clean')
    rm -rf dist/*
    ;;
  *)
    echo "No such build option"
    exit 1
    ;;
esac

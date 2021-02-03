#!/usr/bin/env bash
#
# Small script that prepares install scripts for distribution
#
# - Concats all the parts in a single script under dist/<os>/
# - Creates a tarball under dist/tar/<os>
# - Checksums tarballs

set -euo pipefail

PROGNAME=$0

help_message() {
  cat <<-EOF
  usage: $PROGNAME [OPTION] [ARGUMENT]

  OPTIONS:
    -h                    This help message
    -d DISTRIBUTION_NAME  Builds for a specific distribution. Supported values centos/debian/redhat/ubuntu
EOF
}

checksum() {
  cd dist/tar/"$1" || exit 1
  sha512sum passbolt-ce-installer-"$1"-"$2".tar.gz > SHA512SUMS-$1.txt
  cd -
}

compress() {
  mkdir -p dist/tar/"$1"
  cd dist/"$1" || exit 1
  tar cvfz passbolt-ce-installer-"$1"-"$2".tar.gz *
  cd -
  mv dist/"$1"/passbolt-ce-installer-"$1"-"$2".tar.gz dist/tar/"$1"
}

error() {
  echo "$1"
  help_message
  exit 1
}

build() {
  local os=$1
  local output=dist/"$os"/passbolt_ce_"$os"_installer.sh

  if ! [[ "$os" =~ ^(debian|ubuntu|centos7|centos8|redhat)$ ]]; then
    error "Distribution not supported"
  fi

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

  if [ "$os" == "centos7" ] || [ "$os" == "redhat" ] || [ "$os" == "centos8" ]; then
    for helper in lib/helpers/"$os"/*.sh; do
      cat "$helper" >> "$output";
    done
  fi
  if [ "$os" == "ubuntu" ]; then
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

  if [ "$os" == "redhat" ]; then
    sed -i s:-euo:-eo: "$output"
    sed -i s:/etc/nginx:/etc/opt/rh/rh-nginx116/nginx: "$output"
  fi
}

while getopts "chd:" opt; do
  case $opt in
    h)
      help_message
      exit 0
      ;;
    d)
      build "$OPTARG"
      ;;
    c)
      compress debian 10
      checksum debian 10
      compress centos 7
      checksum centos 7
      compress centos 8
      checksum centos 8
      compress ubuntu 18.04
      checksum ubuntu 18.04
      compress redhat EXPERIMENTAL
      ;;
    *)
      error "No such build option"
      ;;
  esac
done

if [ "$OPTIND" -eq 1 ]; then
  error "Please tell me what to build"
fi

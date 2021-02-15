#!/usr/bin/env bats

@test "not root" {
  run bash dist/centos/passbolt_centos_installer.sh
  [ "$status" -eq 1 ]
}

@test "invalid parameters" {
  run sudo bash dist/centos/passbolt_centos_installer.sh -r -d test
  [ "$status" -eq 1 ]
}

@test "local installation non-interactive non SSL with haveged" {
  echo "curl" >> dist/centos/conf/packages.txt
  run sudo bash dist/centos/passbolt_centos_installer.sh -P root_pass -p passbolt -d passbolt -u passbolt -H passbolt.local -n -e
  [ "$status" -eq 0 ]
}

@test "passbolt is installed on /var/www/passbolt" {
  run stat /var/www/passbolt
  [ "$status" -eq 0 ]
}

@test "it has mysql client installed" {
  run mysql --version
  [ "$status" -eq 0 ]
}

@test "it has mysqld running" {
  run sudo systemctl is-active mariadb
  [ "$status" -eq 0 ]
}

@test "passbolt database user can connect to mysql" {
  run mysql -u passbolt -h localhost -ppassbolt -e ";"
  [ "$status" -eq 0 ]
}

@test "passbolt database user can write on passbolt database" {
  run mysql -u passbolt -h localhost -ppassbolt -e "CREATE TABLE test (testID int);" passbolt
  [ "$status" -eq 0 ]
  mysql -u passbolt -h localhost -ppassbolt -e "DROP TABLE test" passbolt
}


@test "it has nginx installed" {
  run sudo nginx -v
  [ "$status" -eq 0 ]
}

@test "it has nginx running" {
  run sudo systemctl is-active nginx
  [ "$status" -eq 0 ]
}

@test "nginx servername is in place" {
  grep "server_name passbolt.local;" /etc/nginx/conf.d/passbolt*
}

@test "it has gnupg extension loaded" {
  run bash -c "php -m |grep gnupg"
  [ "$status" -eq 0 ]
}

@test "it has haveged running" {
  run sudo systemctl is-active haveged
  [ "$status" -eq 0 ]
}

@test "it has php-fpm running" {
  run sudo systemctl is-active php-fpm
  [ "$status" -eq 0 ]
}

@test "it has cron job set up" {
  sudo grep "* * * * * /var/www/passbolt/bin/cron" /var/spool/cron/nginx
}

@test "gpg keyring is in place" {
  run sudo stat /var/lib/nginx/.gnupg
  [ "$status" -eq 0 ]
}

@test "webinstaller is running" {
  result="$(curl --header 'Host: passbolt.local' -s -o /dev/null -w "%{http_code}" http://127.0.0.1/install)"
  [ "$result" = '200' ]
}


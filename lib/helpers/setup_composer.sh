# require utils/messages.sh
# require utils/errors.sh
composer_check_signature() {
	EXPECTED_SIGNATURE=$(wget -O - https://composer.github.io/installer.sig)
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

	if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
	then
			rm composer-setup.php
			die 'ERROR: Invalid installer signature'
	fi
}

composer_install() {
  local www_user="$1"
  banner "Installing composer..."
	composer_check_signature
  php composer-setup.php --install-dir=/usr/bin
  php -r "unlink('composer-setup.php');"

  banner "Installing composer dependencies..."
  su -c "cd $PASSBOLT_BASE_DIR; composer.phar install -d $PASSBOLT_BASE_DIR --no-dev -o -n" -s /bin/bash "$www_user"
}

# require utils/messages.sh
# require utils/errors.sh
composer_check_signature() {
	EXPECTED_SIGNATURE=$(wget -O - https://composer.github.io/installer.sig)
        wget -O composer-setup.php https://getcomposer.org/installer
	echo "$EXPECTED_SIGNATURE composer-setup.php" | sha384sum -c -

	if [ "$?" != "0" ]
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

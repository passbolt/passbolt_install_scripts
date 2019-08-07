# require ../initializers/_variable_accessor.sh
# require utils/messages.sh
__install_db() {
  local _config_root_pw="$1"
  local _config_user="$2"
  local _config_pw="$3"
  local _config_db="$4"
  local mysql_commands
  mysql_commands=$(cat <<EOF
UPDATE mysql.user SET Password=PASSWORD('$(__config_get "$_config_root_pw")') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE IF NOT EXISTS \`$(__config_get "$_config_db")\`;
GRANT ALL ON \`$(__config_get "$_config_db")\`.* to \`$(__config_get "$_config_user")\`@'localhost' identified by '$(__config_get "$_config_pw")';
UPDATE mysql.user SET plugin = '' WHERE user = 'root' AND host = 'localhost';
FLUSH PRIVILEGES;
EOF
)

  banner "Setting up mariadb..."
  if mysql -u root -e ";";  then
    mysql -u root -e "$mysql_commands"
  elif mysql -u root -p"$(__config_get "$_config_root_pw")" -e ";" ; then
    banner "Trying to connect to to mariadb with provided credentials.."
    mysql -u root -p"$(__config_get "$_config_root_pw")" -e "$mysql_commands"
  else
    banner "Unable to setup mariadb please check manually"
  fi
}

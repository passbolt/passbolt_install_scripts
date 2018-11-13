# require _interactive_option_password.sh
# require _interactive_option_mysql
# require _interactive_option_entropy
# require _interactive_option_hostname
# require _interactive_option_ssl
interactive_prompter() {
  __prompt_mariadb_credentials 'mariadb_root_password' \
                               'mariadb_user' \
                               'mariadb_passbolt_password' \
                               'mariadb_name' \
                               'mariadb_local_installation' \
                               'mariadb_remote_installation'
  __prompt_entropy_check 'haveged_install'
  __prompt_passbolt_hostname 'passbolt_hostname'
  __prompt_ssl 'ssl_auto' \
               'ssl_manual' \
               'ssl_none' \
               'ssl_certificate' \
               'ssl_privkey' \
               'letsencrypt_email'
}

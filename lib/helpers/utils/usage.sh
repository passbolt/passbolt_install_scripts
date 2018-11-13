usage() {
  cat <<-EOF
  usage: $PROGNAME [OPTION] [ARGUMENTS]

  OPTIONS:
    -h                    This help message
    -e                    Enable fast entropy generation with haveged
                          Use with caution as it might lead to unsecure gpg keys

  SSL SETUP OPTIONS:
  ------------------
    -a                    Enable automatic SSL setup using Letsencrypt and certbot.
                          Conflicts with -[ck]
    -c CERT_FILE_PATH     SSL certificate system path. Enables SSL
    -k KEY_FILE_PATH      SSL certificate key path. Enables SSL
    -m EMAIL              Email address to use for letsencrypt registration
    -n                    Disable SSL setup
    -H HOSTNAME           Specifies the hostname nginx will use as server_name
                          and if -a specified it will be used as letsencrypt
                          domain name

  FRESH MARIADB INSTALLATION OPTIONS:
  -----------------------------------
    -d DB_NAME            Specifies the name of the database passbolt will use
                          Conflicts with -r
    -p PASSWORD           Specifies the password of the passbolt database user
                          Conflicts with -r
    -u DB_USERNAME        Specifies the name of the mariadb passbolt database user
                          Conflicts with -r
    -P PASSWORD           Specifies the root database password
                          Conflicts with -r

  PREINSTALLED DATABASE SERVER OR REMOTE DATABASE SERVER:
  -------------------------------------------------------
    -r                    Do not install a local mysql server. Useful for the following scenarios:
                            - Database is in a different server
                            - Manual installation for custom database scenarios
                          Conflicts with: -[dupP]

  EXAMPLES:
  ---------
    Interactive mode. Script will prompt user for details:
    $ $PROGNAME

    Non interactive options:
      - Install local mysql server and use user uploaded certificates:
      $ $PROGNAME -P mysql_root_pass \\
                  -p mysql_passbolt_pass \\
                  -d database_name \\
                  -u database_username \\
                  -H domain_name \\
                  -c path_to_certificate \\
                  -k path_to_certificate_key

      - Install passbolt using remote or preinstalled db:
      $ $PROGNAME -r \\
                  -H domain_name \\
                  -c path_to_certificate \\
                  -k path_to_certificate_key

      - Install with letsencrypt support and remote/preinstalled database:
      $ $PROGNAME -r -H domain_name -a -m my@email.com
EOF

}

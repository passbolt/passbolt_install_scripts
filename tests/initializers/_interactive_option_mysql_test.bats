#!/usr/bin/env bats

setup() {
  source "$BATS_TEST_DIRNAME/../fixtures/utils/constants.sh"
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/messages.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_variable_accessor.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_interactive_option_mysql.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_interactive_option_password.sh"
}

@test "Introduce mariadb creds" {
  __config_data
  __prompt_mariadb_credentials mariadb_root_password mariadb_user mariadb_passbolt_password mariadb_name mariadb_local_installation <<< "
  1
  test
  test
  db_user
  db_pass
  db_pass
  db_name"
  run __config_get mariadb_name
  [ "$status" -eq 0 ]
  [ "$output" = "db_name" ]
}

@test "Doesnt prompt if variables assigned" {
  __config_data
  __config_set mariadb_local_installation true
  __config_set mariadb_root_password test
  __config_set mariadb_user test
  __config_set mariadb_passbolt_password test
  __config_set mariadb_name test
  run __prompt_mariadb_credentials mariadb_root_password mariadb_user mariadb_passbolt_password mariadb_name mariadb_local_installation
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}

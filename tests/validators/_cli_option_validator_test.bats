#!/usr/bin/env bats

setup(){
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/errors.sh"
  source "$BATS_TEST_DIRNAME/../fixtures/validators/output/error_messages.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_variable_accessor.sh"
  source "$BATS_TEST_DIRNAME/../../lib/validators/_cli_option_validator.sh"
}

@test "invalid mysql parameters: -r -d" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/mysql/mysql_invalid_parameters_1.sh"
  run __validate_cli_options
  [ "$status" -eq 1 ]
  [ "$output" = "$wrong_parameters_mysql" ]
}

@test "invalid mysql parameters: -r -d test -P test" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/mysql/mysql_invalid_parameters_2.sh"
  run __validate_cli_options
  [ "$status" -eq 1 ]
  [ "$output" = "$wrong_parameters_mysql" ]
}

@test "invalid ssl parameters: local certificate and letsencrypt" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/ssl/ssl_invalid_parameters_1.sh"
  run __validate_cli_options
  [ "$status" -eq 1 ]
  [ "$output" = "$wrong_parameters_ssl" ]
}

@test "invalid ssl parameters: missing key" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/ssl/ssl_invalid_parameters_2.sh"
  run __validate_cli_options
  [ "$status" -eq 1 ]
  [ "$output" = "$wrong_parameters_ssl" ]
}

@test "invalid ssl parameters: missing certificate" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/ssl/ssl_invalid_parameters_3.sh"
  run __validate_cli_options
  [ "$status" -eq 1 ]
  [ "$output" = "$wrong_parameters_ssl" ]
}

@test "invalid parameters: ssl letsencrypt email and no hostname" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/ssl/ssl_invalid_parameters_4.sh"
  run __validate_cli_options
  [ "$status" -eq 1 ]
  [ "$output" = "$wrong_parameters_ssl" ]
}

@test "correct parameters: mysql remote install" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/mysql/mysql_valid_parameters_1.sh"
  run __validate_cli_options
  [ "$status" -eq 0 ]
}

@test "correct parameters: mysql local install just assign dbname" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/mysql/mysql_valid_parameters_2.sh"
  run __validate_cli_options
  [ "$status" -eq 0 ]
}

@test "correct parameters: ssl local certificates" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/ssl/ssl_valid_parameters_1.sh"
  run __validate_cli_options
  [ "$status" -eq 0 ]
}

@test "correct parameters: ssl letsencrypt email and hostname" {
  skip
  __config_data
  source "$BATS_TEST_DIRNAME/../fixtures/validators/input/ssl/ssl_valid_parameters_2.sh"
  run __validate_cli_options
  [ "$status" -eq 0 ]
}

@test "correct parameters: interactive setup" {
  skip
  __config_data
  run __validate_cli_options
  [ "$status" -eq 0 ]
}

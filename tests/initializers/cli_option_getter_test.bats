#!/usr/bin/env bats

setup() {
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/errors.sh"
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/messages.sh"
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/usage.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_variable_accessor.sh"
  source "$BATS_TEST_DIRNAME/../../lib/validators/_cli_option_validator.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/cli_option_getter.sh"
}

@test "invalid flag" {
  run get_options -F
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "Invalid option" ]
}

@test "prints usage" {
  expected_output=$(disclaimer; usage)
  run get_options -h
  [ "$status" -eq 0 ]
  [ "$output" = "$expected_output" ]
}

@test "invalid mysql parameters: -r -d database_name" {
  __config_data
  run get_options -r -d database_name
  [ "$status" -eq 1 ]
}

@test "invalid mysql parameters (empty): -r -d \"\"" {
  __config_data
  run get_options -r -d ""
  [ "$status" -eq 1 ]
}

@test "invalid mysql parameters (empty): -r -u user" {
  __config_data
  run get_options -r -u user
  [ "$status" -eq 1 ]
}

@test "invalid mysql parameters (empty): -r -p pass" {
  __config_data
  run get_options -r -p pass
  [ "$status" -eq 1 ]
}

@test "invalid mysql parameters (empty): -r -P pass" {
  __config_data
  run get_options -r -P pass
  [ "$status" -eq 1 ]
}

@test "invalid mysql parameters missing db: -u user -p password -P password" {
  skip
  __config_data
  run get_options -u user -p password -P password
  [ "$status" -eq 1 ]
}

@test "invalid mysql parameters missing db: -u user -p password -P password" {
  skip
  __config_data
  run get_options -u user -p password -P password
  [ "$status" -eq 1 ]
}

@test "invalid mysql parameters empty passwd: -d database -u user -p \"\" -P password" {
  skip
  __config_data
  run get_options -d -u user -p "" -P password
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters manual and automated: -c "test" -a" {
  __config_data
  run get_options -c test -a
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters local and automated: -c \"\" -a" {
  __config_data
  run get_options -c "" -a
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters local and automated: -k "key" -a" {
  __config_data
  run get_options -k "key" -a
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters: missing key (empty string)" {
  __config_data
  run get_options -c "test" -k ""
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters: missing key arg not provided" {
  __config_data
  run get_options -c "test" -k
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters: missing key parameter not passed" {
  __config_data
  run get_options -c "test"
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters: missing certificate parameter not passed" {
  __config_data
  run get_options -k "test"
  [ "$status" -eq 1 ]
}

@test "valid mysql parameters: mysql remote install" {
  __config_data
  run get_options -r
  [ "$status" -eq 0 ]
}

@test "valid mysql parameters: -d database_name" {
  __config_data
  run get_options -d database_name
  [ "$status" -eq 0 ]
}
@test "valid mysql parameters: -d database_name -u user -p password -P password" {
  __config_data
  run get_options -d database_name -u user -p password -P password
  [ "$status" -eq 0 ]
}

@test "invalid ssl parameters lets encrypt" {
  __config_data
  run get_options -a
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters lets encrypt" {
  __config_data
  run get_options -n -c 'cert' -k 'key'
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters lets encrypt" {
  __config_data
  run get_options -n -m
  [ "$status" -eq 1 ]
}

@test "invalid ssl parameters lets encrypt" {
  __config_data
  run get_options -n -a
  [ "$status" -eq 1 ]
}


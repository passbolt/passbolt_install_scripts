#!/usr/bin/env bats

setup() {
  source "$BATS_TEST_DIRNAME/../fixtures/utils/constants.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_variable_accessor.sh"
}

@test "set a variable" {
  __config_data
  run __config_set 'foo' 'bar'
  [ "$status" -eq 0 ]
}

@test "get a variable value" {
  __config_data
  __config_set 'bar' 'baz'
  run __config_get 'bar'
  [ "$status" -eq 0 ]
  [ "$output" = "baz" ]
}

@test "get an empty string" {
  __config_data
  __config_set 'bar' ''
  run __config_get 'bar'
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}

@test "get a non existent entry" {
  __config_data
  run __config_get 'foo'
  [ "$output" = "" ]
}

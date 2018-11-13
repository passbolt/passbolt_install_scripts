#!/usr/bin/env bats

setup(){
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/errors.sh"
  source "$BATS_TEST_DIRNAME/../../lib/validators/_os_validator.sh"
}

@test "release supported equal" {
  run __validate_os_version "9.0" "9.0"
  [ "$status" -eq 0 ]
}

@test "release supported superior" {
  run __validate_os_version "9.1" "9.0"
  [ "$status" -eq 0 ]
}

@test "release not supported" {
  run __validate_os_version "6.4.2" "9.0"
  echo "$output"
  [ "$status" -eq 1 ]
}


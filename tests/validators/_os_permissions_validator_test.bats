#!/usr/bin/env bats

setup(){
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/errors.sh"
  source "$BATS_TEST_DIRNAME/../../lib/validators/_os_permissions_validator.sh"
}

@test "OS permission: not root" {
  run __validate_os_permissions
  [ "$status" -eq 1 ]
}

#!/usr/bin/env bats

setup(){
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/errors.sh"
  source "$BATS_TEST_DIRNAME/../../lib/helpers/package_installer.sh"
  source "$BATS_TEST_DIRNAME/../fixtures/helpers/output/error_messages.sh"
}

@test "valid package manager (debian)" {
  export OS=debian
  run __installer_command
  [ "$status" -eq 0 ]
  [ "$output" = "apt-get" ]
}

@test "invalid package manager" {
  export OS=foo
  run __installer_command
  [ "$status" -eq 1 ]
}



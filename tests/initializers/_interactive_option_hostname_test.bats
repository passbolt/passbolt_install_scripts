#!/usr/bin/env bats

setup() {
  source "$BATS_TEST_DIRNAME/../fixtures/utils/constants.sh"
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/messages.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_variable_accessor.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_interactive_option_hostname.sh"
}

@test "Sets host config var" {
  __config_data
  __prompt_passbolt_hostname passbolt_hostname <<< "dummy_host"
  result="$(__config_get passbolt_hostname)"
  [ "$result" = "dummy_host" ]
}

@test "Host config already provided so no prompt" {
  __config_data
  __config_set passbolt_hostname "dummy_host"
  run __prompt_passbolt_hostname passbolt_hostname
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}


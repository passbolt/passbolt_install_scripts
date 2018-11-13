#!/usr/bin/env bats

setup() {
  source "$BATS_TEST_DIRNAME/../fixtures/utils/constants.sh"
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/messages.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_variable_accessor.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_interactive_option_entropy.sh"
}

@test "Install haveged" {
  __config_data
  __prompt_entropy_check haveged_install <<< "1"
  result="$(__config_get haveged_install)"
  [ "$result" = "true" ]
}

@test "Entropy check doesnt prompt" {
  __config_data
  __config_set haveged_install true
  run __prompt_entropy_check haveged_install
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}


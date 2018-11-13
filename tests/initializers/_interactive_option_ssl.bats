#!/usr/bin/env bats

setup() {
  source "$BATS_TEST_DIRNAME/../fixtures/utils/constants.sh"
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/messages.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_variable_accessor.sh"
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_interactive_option_ssl.sh"
}

@test "Installs ssl manual mode" {
  __config_data
  __prompt_ssl ssl_auto ssl_manual ssl_none ssl_certificate ssl_privkey letsencrypt_email <<< "1
  /this/cert/path
  /that/key/path"
  result="$(__config_get ssl_manual)"
  result_cert="$(__config_get ssl_certificate)"
  result_key="$(__config_get ssl_privkey)"
  [ "$result" = "true" ]
  [ "$result_cert" = "/this/cert/path" ]
  [ "$result_key" = "/that/key/path" ]
}

@test "Doesnt prompt ssl install" {
  __config_data
  __config_set letsencrypt_email 'test'
  __config_set ssl_auto true
  __prompt_ssl ssl_auto ssl_manual ssl_none ssl_certificate ssl_privkey letsencrypt_email
  result="$(__config_get ssl_auto)"
  [ "$result" = "true" ]
}

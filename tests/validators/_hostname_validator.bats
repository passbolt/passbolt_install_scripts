#!/usr/bin/env bats

setup(){
  source "$BATS_TEST_DIRNAME/../../lib/initializers/_variable_accessor.sh"
  source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/messages.sh"
  source "$BATS_TEST_DIRNAME/../../lib/validators/_hostname_validator.sh"
}

@test "invalid ip address ports" {
  run __validate_hostname '192.168.0.1:123'
  [ "$output" = "false" ]
}

@test "invalid ip address short" {
  run __validate_hostname '192.1.2'
  [ "$output" = "false" ]
}

@test "invalid ip address long" {
  run __validate_hostname '192.168.0.1.2'
  [ "$output" = "false" ]
}

@test "invalid ip address ipv6" {
  run __validate_hostname '2001:0db8:85a3:0000:0000:8a2e:0370:7334'
  [ "$output" = "false" ]
}

@test "invalid domain name: test" {
  run __validate_hostname 'test'
  [ "$output" = "false" ]
}

@test "valid domain name: a.b.c.com" {
  run __validate_hostname 'a.b.c.com'
  [ "$output" = "true" ]
}

@test "valid domain name: a.2.c.co" {
  run __validate_hostname 'a.2.c.co'
  [ "$output" = "true" ]
}

@test "valid domain name: t.co" {
  run __validate_hostname 't.co'
  [ "$output" = "true" ]
}

@test "valid domain name: a-2.c.com" {
  run __validate_hostname 'a-2.c.com'
  [ "$output" = "true" ]
}

@test "valid ip address" {
  run __validate_hostname '192.168.0.1'
  [ "$output" = "true" ]
}

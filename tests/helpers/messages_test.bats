#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/../../lib/helpers/utils/messages.sh"

@test "small string" {
  run banner "abcd"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "====" ]
  [ "${lines[1]}" = "abcd" ]
  [ "${lines[2]}" = "====" ]
}

@test "string longer than 80 chars" {
  result="$(banner "this is a message longer than 80 characters that should be splitted in multiple\nLINES" |wc -l)"
  [ "$result" = 4 ]
}

@test "small string with \n" {
  result="$(banner "line1\nline2\nline3" |wc -l)"
  [ "$result" = 5 ]
}

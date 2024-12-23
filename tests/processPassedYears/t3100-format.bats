#!/usr/bin/env bats

load fixture

@test "output with short year" {
    setDate 2020-04-20
    run processPassedYears --id ID -- false

    setDate 2021-05-11
    LC_ALL=C run -0 processPassedYears --id ID --format "'%y" -- printf '[%s]-'
    assert_output "['20]-"
}

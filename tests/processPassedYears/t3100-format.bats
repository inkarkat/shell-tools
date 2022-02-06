#!/usr/bin/env bats

load fixture

@test "output with short year" {
    setDate 2020-04-20
    run processPassedYears --id ID -- false

    setDate 2021-05-11
    LC_ALL=C run processPassedYears --id ID --format "'%y" -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "['20]-" ]
}

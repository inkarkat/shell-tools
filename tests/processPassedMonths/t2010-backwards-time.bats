#!/usr/bin/env bats

load fixture

@test "call with a date one month in the past exits with 4" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-03-20
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 4 ]
    [ "$output" = "" ]
}

@test "call with a date 11 months in the past exits with 4" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2020-05-20
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 4 ]
    [ "$output" = "" ]
}

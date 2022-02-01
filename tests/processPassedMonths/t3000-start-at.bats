#!/usr/bin/env bats

load fixture

@test "initial call with start three months prior passes the last three months" {
    setDate 2021-04-20
    run processPassedMonths --id ID --start-at 2021-01 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-01]-[2021-02]-[2021-03]-" ]
}

@test "initial call with start on this month exits with 99" {
    setDate 2021-04-20
    run processPassedMonths --id ID --start-at 2021-04 -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "initial call with start next month exits with 99 and also when invoked on the next month" {
    setDate 2021-04-20
    run processPassedMonths --id ID --start-at 2021-05 -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]

    setDate 2021-05-20
    run processPassedMonths --id ID -- printf '[%s]-' 2>&3
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "initial call with start next month passed that month when invoked two months in the future" {
    setDate 2021-04-20
    run processPassedMonths --id ID --start-at 2021-05 -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]

    setDate 2021-06-06
    run processPassedMonths --id ID -- printf '[%s]-' 2>&3
    [ $status -eq 0 ]
    [ "$output" = "[2021-05]-" ]
}

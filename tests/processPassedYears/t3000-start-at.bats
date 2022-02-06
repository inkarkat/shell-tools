#!/usr/bin/env bats

load fixture

@test "initial call with start three years prior passes the last three years" {
    setDate 2021-04-20
    run processPassedYears --id ID --start-at 2018 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2018]-[2019]-[2020]-" ]
}

@test "initial call with start on this year exits with 99" {
    setDate 2021-04-20
    run processPassedYears --id ID --start-at 2021 -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "initial call with start next year exits with 99 and also when invoked on the next year" {
    setDate 2020-04-20
    run processPassedYears --id ID --start-at 2021 -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]

    setDate 2021-05-20
    run processPassedYears --id ID -- printf '[%s]-' 2>&3
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "initial call with start next year passed that year when invoked two years in the future" {
    setDate 2019-04-20
    run processPassedYears --id ID --start-at 2020 -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]

    setDate 2021-06-06
    run processPassedYears --id ID -- printf '[%s]-' 2>&3
    [ $status -eq 0 ]
    [ "$output" = "[2020]-" ]
}

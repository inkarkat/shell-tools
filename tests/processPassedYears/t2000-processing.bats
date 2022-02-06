#!/usr/bin/env bats

load fixture

@test "initial call exits with 99" {
    run processPassedYears --id ID -- printf '[%s]-'

    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "call on the same year exits with 99" {
    setDate 2021-04-20
    run processPassedYears --id ID -- false

    setDate 2021-05-30
    run processPassedYears --id ID -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "call on the following year passes the last year to simple command" {
    setDate 2020-04-20
    run processPassedYears --id ID -- false

    setDate 2021-05-11
    run processPassedYears --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2020]-" ]
}

@test "second call on the following year exits with 99" {
    setDate 2020-04-20
    run processPassedYears --id ID -- false

    setDate 2021-05-11
    run processPassedYears --id ID -- printf '[%s]-'

    setDate 2021-06-12
    run processPassedYears --id ID -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "call two years later passes the previous two years to simple command" {
    setDate 2019-04-20
    run processPassedYears --id ID -- false

    setDate 2021-06-01
    run processPassedYears --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2019]-[2020]-" ]
}

@test "another call three years later passes the previous three years to simple command" {
    setDate 2016-04-20
    run processPassedYears --id ID -- false

    setDate 2018-06-01
    run processPassedYears --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2016]-[2017]-" ]

    setDate 2021-09-01
    run processPassedYears --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2018]-[2019]-[2020]-" ]
}

@test "call seven years later passes the previous seven years to simple command" {
    setDate 2014-04-20
    run processPassedYears --id ID -- false

    setDate 2021-11-30
    run processPassedYears --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2014]-[2015]-[2016]-[2017]-[2018]-[2019]-[2020]-" ]
}


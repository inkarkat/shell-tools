#!/usr/bin/env bats

load fixture

@test "initial call with start six years prior passes the last 2 years" {
    setDate 2021-05-05
    run processPassedYears --id ID --start-at 2015 --initial-last 2 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2019]-[2020]-" ]
    assert_last_year 2021
}

@test "initial call with start six years prior passes the last 2 years and a later call no more" {
    setDate 2021-05-05
    run processPassedYears --id ID --start-at 2015 --initial-last 2 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2019]-[2020]-" ]
    assert_last_year 2021

    setDate 2021-05-10
    run processPassedYears --id ID --start-at 2015 --initial-last 2 -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]
    assert_last_year 2021
}

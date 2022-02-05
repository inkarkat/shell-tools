#!/usr/bin/env bats

load fixture

@test "initial call with start three years prior passes all first 3 years" {
    setDate 2021-03-05
    run processPassedYears --id ID --start-at 2018 --max-first 2 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2018]-[2019]-[2020]-" ]
    assert_last_year 2021
}

@test "subsequent call after six years passes first 2 years" {
    setDate 2015-03-05
    run processPassedYears --id ID --start-at 2012 --max-first 2 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2012]-[2013]-[2014]-" ]
    assert_last_year 2015

    setDate 2021-09-09
    run processPassedYears --id ID --start-at 2012 --max-first 2 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2015]-[2016]-" ]
    assert_last_year 2017
}

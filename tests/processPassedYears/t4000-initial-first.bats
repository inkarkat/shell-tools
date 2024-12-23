#!/usr/bin/env bats

load fixture

@test "initial call with start six years prior passes the first 2 years" {
    setDate 2021-05-05
    run -0 processPassedYears --id ID --start-at 2015 --initial-first 2 -- printf '[%s]-'
    assert_output '[2015]-[2016]-'
    assert_last_year 2017
}

@test "initial call with start six years prior passes the first 2 years and a later call the remaining 4" {
    setDate 2021-05-05
    run -0 processPassedYears --id ID --start-at 2015 --initial-first 2 -- printf '[%s]-'
    assert_output '[2015]-[2016]-'

    setDate 2021-05-10
    run -0 processPassedYears --id ID --start-at 2015 --initial-first 2 -- printf '[%s]-'
    assert_output '[2017]-[2018]-[2019]-[2020]-'
    assert_last_year 2021
}

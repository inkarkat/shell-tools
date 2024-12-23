#!/usr/bin/env bats

load fixture

@test "initial call passed just the first two and a later call the first four" {
    setDate 2015-03-05
    run -0 processPassedYears --id ID --start-at 2012 --initial-first 2 --max-first 4 -- printf '[%s]-'
    assert_output '[2012]-[2013]-'
    assert_last_year 2014

    setDate 2021-09-05
    run -0 processPassedYears --id ID --start-at 2012 --initial-first 2 --max-first 4 -- printf '[%s]-'
    assert_output '[2014]-[2015]-[2016]-[2017]-'
    assert_last_year 2018
}

@test "initial call passed just the last two and a later call the last four" {
    setDate 2015-03-05
    run -0 processPassedYears --id ID --start-at 2012 --initial-last 2 --max-last 4 -- printf '[%s]-'
    assert_output '[2013]-[2014]-'
    assert_last_year 2015

    setDate 2021-09-05
    run -0 processPassedYears --id ID --start-at 2012 --initial-last 2 --max-last 4 -- printf '[%s]-'
    assert_output '[2017]-[2018]-[2019]-[2020]-'
    assert_last_year 2021
}

@test "initial call passed just the first two and a later call the last four" {
    setDate 2015-03-05
    run -0 processPassedYears --id ID --start-at 2012 --initial-first 2 --max-last 4 -- printf '[%s]-'
    assert_output '[2012]-[2013]-'
    assert_last_year 2014

    setDate 2021-09-05
    run -0 processPassedYears --id ID --start-at 2012 --initial-first 2 --max-last 4 -- printf '[%s]-'
    assert_output '[2017]-[2018]-[2019]-[2020]-'
    assert_last_year 2021
}

@test "initial call passed just the last two and a later call the first four" {
    setDate 2015-03-05
    run -0 processPassedYears --id ID --start-at 2012 --initial-last 2 --max-first 4 -- printf '[%s]-'
    assert_output '[2013]-[2014]-'
    assert_last_year 2015

    setDate 2021-09-05
    run -0 processPassedYears --id ID --start-at 2012 --initial-last 2 --max-first 4 -- printf '[%s]-'
    assert_output '[2015]-[2016]-[2017]-[2018]-'
    assert_last_year 2019
}

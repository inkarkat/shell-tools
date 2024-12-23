#!/usr/bin/env bats

load fixture

@test "initial call with start six months prior passes the last 2 months" {
    setDate 2021-05-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-last 2 -- printf '[%s]-'
    assert_output '[2021-03]-[2021-04]-'
    assert_last_month 2021 5
}

@test "initial call with start six months prior passes the last 2 months and a later call no more" {
    setDate 2021-05-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-last 2 -- printf '[%s]-'
    assert_output '[2021-03]-[2021-04]-'
    assert_last_month 2021 5

    setDate 2021-05-10
    run -99 processPassedMonths --id ID --start-at 2020-12 --initial-last 2 -- printf '[%s]-'
    assert_output ''
    assert_last_month 2021 5
}

@test "initial call with start 18 months prior passes the last 2 months" {
    setDate 2021-05-05
    run -0 processPassedMonths --id ID --start-at 2019-12 --initial-last 2 -- printf '[%s]-'
    assert_output '[2021-03]-[2021-04]-'
    assert_last_month 2021 5
}

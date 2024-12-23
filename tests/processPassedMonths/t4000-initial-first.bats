#!/usr/bin/env bats

load fixture

@test "initial call with start six months prior passes the first 2 months" {
    setDate 2021-05-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-first 2 -- printf '[%s]-'
    assert_output '[2020-12]-[2021-01]-'
    assert_last_month 2021 2
}

@test "initial call with start five months prior passes the first 2 months and a later call the remaining 3" {
    setDate 2021-05-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-first 2 -- printf '[%s]-'
    assert_output '[2020-12]-[2021-01]-'

    setDate 2021-05-10
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-first 2 -- printf '[%s]-'
    assert_output '[2021-02]-[2021-03]-[2021-04]-'
    assert_last_month 2021 5
}

@test "initial call with start 18 months prior passes the first 2 months" {
    setDate 2021-05-05
    run -0 processPassedMonths --id ID --start-at 2019-12 --initial-first 2 -- printf '[%s]-'
    assert_output '[2019-12]-[2020-01]-'
    assert_last_month 2020 2
}

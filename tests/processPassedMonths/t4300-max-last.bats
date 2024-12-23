#!/usr/bin/env bats

load fixture

@test "initial call with start three months prior passes all last 3 months" {
    setDate 2021-03-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --max-last 2 -- printf '[%s]-'
    assert_output '[2020-12]-[2021-01]-[2021-02]-'
    assert_last_month 2021 3
}

@test "subsequent call after six months passes last 2 months" {
    setDate 2021-03-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --max-last 2 -- printf '[%s]-'
    assert_output '[2020-12]-[2021-01]-[2021-02]-'
    assert_last_month 2021 3

    setDate 2021-09-09
    run -0 processPassedMonths --id ID --start-at 2020-12 --max-last 2 -- printf '[%s]-'
    assert_output '[2021-07]-[2021-08]-'
    assert_last_month 2021 9
}

@test "subsequent call after 18 months passes last 2 months" {
    setDate 2020-03-05
    run -0 processPassedMonths --id ID --start-at 2019-12 --max-last 2 -- printf '[%s]-'
    assert_output '[2019-12]-[2020-01]-[2020-02]-'
    assert_last_month 2020 3

    setDate 2021-09-09
    run -0 processPassedMonths --id ID --start-at 2020-12 --max-last 2 -- printf '[%s]-'
    assert_output '[2021-07]-[2021-08]-'
    assert_last_month 2021 9
}

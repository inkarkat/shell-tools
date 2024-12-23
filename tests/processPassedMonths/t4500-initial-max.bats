#!/usr/bin/env bats

load fixture

@test "initial call passed just the first two and a later call the first four" {
    setDate 2021-03-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-first 2 --max-first 4 -- printf '[%s]-'
    assert_output '[2020-12]-[2021-01]-'
    assert_last_month 2021 2

    setDate 2021-09-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-first 2 --max-first 4 -- printf '[%s]-'
    assert_output '[2021-02]-[2021-03]-[2021-04]-[2021-05]-'
    assert_last_month 2021 6
}

@test "initial call passed just the last two and a later call the last four" {
    setDate 2021-03-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-last 2 --max-last 4 -- printf '[%s]-'
    assert_output '[2021-01]-[2021-02]-'
    assert_last_month 2021 3

    setDate 2021-09-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-last 2 --max-last 4 -- printf '[%s]-'
    assert_output '[2021-05]-[2021-06]-[2021-07]-[2021-08]-'
    assert_last_month 2021 9
}

@test "initial call passed just the first two and a later call the last four" {
    setDate 2021-03-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-first 2 --max-last 4 -- printf '[%s]-'
    assert_output '[2020-12]-[2021-01]-'
    assert_last_month 2021 2

    setDate 2021-09-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-first 2 --max-last 4 -- printf '[%s]-'
    assert_output '[2021-05]-[2021-06]-[2021-07]-[2021-08]-'
    assert_last_month 2021 9
}

@test "initial call passed just the last two and a later call the first four" {
    setDate 2021-03-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-last 2 --max-first 4 -- printf '[%s]-'
    assert_output '[2021-01]-[2021-02]-'
    assert_last_month 2021 3

    setDate 2021-09-05
    run -0 processPassedMonths --id ID --start-at 2020-12 --initial-last 2 --max-first 4 -- printf '[%s]-'
    assert_output '[2021-03]-[2021-04]-[2021-05]-[2021-06]-'
    assert_last_month 2021 7
}

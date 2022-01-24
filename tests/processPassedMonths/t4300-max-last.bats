#!/usr/bin/env bats

load fixture

@test "initial call with start three months prior passes all last 3 months" {
    setDate 2021-03-05
    run processPassedMonths --id ID --start-at 2020-12 --max-last 2 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2020-12]-[2021-01]-[2021-02]-" ]
    assert_last_month 2021 3
}

@test "subsequent call after six months passes last 2 months" {
    setDate 2021-03-05
    run processPassedMonths --id ID --start-at 2020-12 --max-last 2 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2020-12]-[2021-01]-[2021-02]-" ]
    assert_last_month 2021 3

    setDate 2021-09-09
    run processPassedMonths --id ID --start-at 2020-12 --max-last 2 -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-07]-[2021-08]-" ]
    assert_last_month 2021 9
}

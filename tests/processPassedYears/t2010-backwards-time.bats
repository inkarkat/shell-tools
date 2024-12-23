#!/usr/bin/env bats

load fixture

@test "call with a date one year in the past exits with 99" {
    setDate 2021-04-20
    run processPassedYears --id ID -- false

    setDate 2020-03-20
    run -99 processPassedYears --id ID -- printf '[%s]-'
    assert_output ''
}

@test "call with a date 11 years in the past exits with 99" {
    setDate 2021-04-20
    run processPassedYears --id ID -- false

    setDate 2010-05-20
    run -99 processPassedYears --id ID -- printf '[%s]-'
    assert_output ''
}

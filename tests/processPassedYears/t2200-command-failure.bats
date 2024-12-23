#!/usr/bin/env bats

load fixture

@test "a failing command gets its exit status returned and does not modify the database" {
    setDate 2020-04-20
    run processPassedYears --id ID -- false

    setDate 2021-05-11
    run -66 processPassedYears --id ID --command '(printf %s {}; exit 66)'
    assert_output '2020'
    assert_last_year 2020
}

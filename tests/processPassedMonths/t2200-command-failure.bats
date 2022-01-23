#!/usr/bin/env bats

load fixture

@test "a failing command gets its exit status returned and does not modify the database" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-05-11
    run processPassedMonths --id ID --command '(printf %s {}; exit 66)'
    [ $status -eq 66 ]
    [ "$output" = "2021-04" ]
    assert_last_month 2021 4
}

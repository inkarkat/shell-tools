#!/usr/bin/env bats

load fixture

@test "output with different month, year order" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-05-11
    LC_ALL=C run -0 processPassedMonths --id ID --format '%-m, %Y' -- printf '[%s]-'
    assert_output '[4, 2021]-'
}

@test "output with full month name and short year" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-05-11
    LC_ALL=C run -0 processPassedMonths --id ID --format "%B'%y" -- printf '[%s]-'
    assert_output "[April'21]-"
}

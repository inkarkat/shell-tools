#!/usr/bin/env bats

load fixture

@test "when the second update has no newer results, 99 is returned immediately without another initial call" {
    NEWERFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --newer -- printf '[%s]-'

    assert_output "[foo]-[bar]-[with space]-"
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last 1003

    NEWERFILES='something else'
    run -0 processAddedFiles --id ID --newer -- printf '[%s]-'

    assert_output "[something else]-"
    assert_args '> --include-epoch --newer-than 1003 --'
    assert_last 1001

    NEWERFILES=''
    run processAddedFiles --id ID --newer -- printf '[%s]-'

    NEWERFILES_EXIT=99
    assert_output ''
    assert_args '> --include-epoch --newer-than 1001 --'
    assert_last 1001
}



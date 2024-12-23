#!/usr/bin/env bats

load fixture

@test "failing to retrieve the initial files does not modify the database, not run commands, and returns 99" {
    LASTFILES_EXIT=1
    run -99 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output ''
    assert_args '--count 2147483647 --'
    assert_last ''
}

@test "retrieving no initial files does not modify the database, not run commands, and returns 99" {
    LASTFILES=''
    run -99 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output ''
    assert_args '--count 2147483647 --'
    assert_last ''
}

@test "failing to retrieve later files does not modify the database, not run commands, and returns 99" {
    LASTFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output "[foo]-[bar]-[with space]-"
    assert_args '--count 2147483647 --'
    assert_last 'with space'

    LASTFILES_EXIT=1
    LASTFILES=''
    run -99 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output ''
    assert_args '--after with\ space --'
    assert_last 'with space'
}

@test "retrieving no later files does not modify the database, not run commands, and returns 99" {
    LASTFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output "[foo]-[bar]-[with space]-"
    assert_args '--count 2147483647 --'
    assert_last 'with space'

    LASTFILES=''
    run -99 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output ''
    assert_args '--after with\ space --'
    assert_last 'with space'
}

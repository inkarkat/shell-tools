#!/usr/bin/env bats

load fixture

@test "initial call passes just the first two and a later update passes the first four" {
    LASTFILES='one\ntwo\nthree'
    run -0 processAddedFiles --id ID --after --initial-first 2 --max-first 4 -- printf '[%s]-'

    assert_output "[one]-[two]-"
    assert_args '--count 2147483647 --'
    assert_last 'two'

    LASTFILES='three\nfour\nfive\nsix\nseven\neight'
    run -0 processAddedFiles --id ID --after --initial-first 2 --max-first 4 -- printf '[%s]-'

    assert_output "[three]-[four]-[five]-[six]-"
    assert_args '--after two --'
    assert_last 'six'
}

@test "initial call passes just the last two and a later update passes the last four" {
    LASTFILES='one\ntwo\nthree'
    run -0 processAddedFiles --id ID --after --initial-last 2 --max-last 4 -- printf '[%s]-'

    assert_output "[two]-[three]-"
    assert_args '--count 2147483647 --'
    assert_last 'three'

    LASTFILES='four\nfive\nsix\nseven\neight\nnine'
    run -0 processAddedFiles --id ID --after --initial-last 2 --max-last 4 -- printf '[%s]-'

    assert_output "[six]-[seven]-[eight]-[nine]-"
    assert_args '--after three --'
    assert_last 'nine'
}

@test "initial call passes just the first two and a later update passes the last three" {
    LASTFILES='one\ntwo\nthree'
    run -0 processAddedFiles --id ID --after --initial-first 2 --max-last 3 -- printf '[%s]-'

    assert_output "[one]-[two]-"
    assert_args '--count 2147483647 --'
    assert_last 'two'

    LASTFILES='three\nfour\nfive\nsix\nseven\neight'
    run -0 processAddedFiles --id ID --after --initial-first 2 --max-last 3 -- printf '[%s]-'

    assert_output "[six]-[seven]-[eight]-"
    assert_args '--after two --'
    assert_last 'eight'
}

@test "initial call passes just the last two and a later update passes the first three" {
    LASTFILES='one\ntwo\nthree'
    run -0 processAddedFiles --id ID --after --initial-last 2 --max-first 3 -- printf '[%s]-'

    assert_output "[two]-[three]-"
    assert_args '--count 2147483647 --'
    assert_last 'three'

    LASTFILES='four\nfive\nsix\nseven\neight\nnine'
    run -0 processAddedFiles --id ID --after --initial-last 2 --max-first 3 -- printf '[%s]-'

    assert_output "[four]-[five]-[six]-"
    assert_args '--after three --'
    assert_last 'six'
}


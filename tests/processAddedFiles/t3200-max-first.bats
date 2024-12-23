#!/usr/bin/env bats

load fixture

@test "initial call passes all, update call queries all later files and passes first 2" {
    LASTFILES='one\ntwo\nthree\nfour\nfive'
    run -0 processAddedFiles --id ID --after --max-first 2 -- printf '[%s]-'

    assert_output "[one]-[two]-[three]-[four]-[five]-"
    assert_args '--count 2147483647 --'
    assert_last 'five'

    LASTFILES='six\nseven\neight\nnine\nten'
    run -0 processAddedFiles --id ID --after --max-first 2 -- printf '[%s]-'

    assert_output "[six]-[seven]-"
    assert_args '--after five --'
    assert_last 'seven'
}

@test "initial call passes all, update call queries all later files and passes just the first" {
    LASTFILES='one\ntwo\nthree\nfour\nfive'
    run -0 processAddedFiles --id ID --after --max-first 1 -- printf '[%s]-'

    assert_output "[one]-[two]-[three]-[four]-[five]-"
    assert_args '--count 2147483647 --'
    assert_last 'five'

    LASTFILES='six\nseven\neight\nnine\nten'
    run -0 processAddedFiles --id ID --after --max-first 1 -- printf '[%s]-'

    assert_output "[six]-"
    assert_args '--after five --'
    assert_last 'six'
}

@test "initial call passes all, update call queries all newer files and passes first 2" {
    NEWERFILES='one\ntwo\nthree\nfour\nfive'
    run -0 processAddedFiles --id ID --newer --max-first 1 -- printf '[%s]-'

    assert_output "[one]-[two]-[three]-[four]-[five]-"
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last '1005'

    NEWERFILES='six\nseven\neight\nnine\nten'
    run -0 processAddedFiles --id ID --newer --max-first 1 -- printf '[%s]-'

    assert_output "[six]-"
    assert_args '> --include-epoch --newer-than 1005 --'
    assert_last '1001'
}

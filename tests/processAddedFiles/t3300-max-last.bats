#!/usr/bin/env bats

load fixture

@test "initial call passes all, update call queries all later files and passes last 2" {
    LASTFILES='one\ntwo\nthree\nfour\nfive'
    run -0 processAddedFiles --id ID --after --max-last 2 -- printf '[%s]-'

    assert_output "[one]-[two]-[three]-[four]-[five]-"
    assert_args '--count 2147483647 --'
    assert_last 'five'

    LASTFILES='six\nseven\neight\nnine'
    run -0 processAddedFiles --id ID --after --max-last 2 -- printf '[%s]-'

    assert_output "[eight]-[nine]-"
    assert_args '--after five --'
    assert_last 'nine'
}

@test "initial call passes all, update call queries all later files and passes just the last" {
    LASTFILES='one\ntwo\nthree\nfour\nfive'
    run -0 processAddedFiles --id ID --after --max-last 1 -- printf '[%s]-'

    assert_output "[one]-[two]-[three]-[four]-[five]-"
    assert_args '--count 2147483647 --'
    assert_last 'five'

    LASTFILES='six\nseven\neight\nnine'
    run -0 processAddedFiles --id ID --after --max-last 1 -- printf '[%s]-'

    assert_output "[nine]-"
    assert_args '--after five --'
    assert_last 'nine'
}

@test "initial call passes all, update call queries all newer files and passes last 2" {
    NEWERFILES='one\ntwo\nthree\nfour\nfive'
    run -0 processAddedFiles --id ID --newer --max-last 1 -- printf '[%s]-'

    assert_output "[one]-[two]-[three]-[four]-[five]-"
    assert_args '> --include-epoch --newer-than 0 --'
    assert_last '1005'

    NEWERFILES='six\nseven\neight\nnine'
    run -0 processAddedFiles --id ID --newer --max-last 1 -- printf '[%s]-'

    assert_output "[nine]-"
    assert_args '> --include-epoch --newer-than 1005 --'
    assert_last '1004'
}

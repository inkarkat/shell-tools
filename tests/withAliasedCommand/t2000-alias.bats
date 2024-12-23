#!/usr/bin/env bats

load fixture

@test "alias definition via NAME=ALIAS-COMMAND" {
    run -0 withAliasedCommand foo=/bin/echo -- foo testing this
    assert_output 'testing this'
}

@test "alias definition via --alias-command" {
    run -0 withAliasedCommand --name foo --alias-command '/bin/echo "$@"' -- foo testing this
    assert_output 'testing this'
}

@test "alias definition via --alias" {
    run -0 withAliasedCommand --name foo --alias /bin/echo \; -- foo testing this
    assert_output 'testing this'
}

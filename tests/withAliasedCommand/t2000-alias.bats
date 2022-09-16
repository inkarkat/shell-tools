#!/usr/bin/env bats

@test "alias definition via NAME=ALIAS-COMMAND" {
    run withAliasedCommand foo=/bin/echo -- foo testing this
    [ $status -eq 0 ]
    [ "$output" = "testing this" ]
}

@test "alias definition via --alias-command" {
    run withAliasedCommand --name foo --alias-command '/bin/echo "$@"' -- foo testing this
    [ $status -eq 0 ]
    [ "$output" = "testing this" ]
}

@test "alias definition via --alias" {
    run withAliasedCommand --name foo --alias /bin/echo \; -- foo testing this
    [ $status -eq 0 ]
    [ "$output" = "testing this" ]
}

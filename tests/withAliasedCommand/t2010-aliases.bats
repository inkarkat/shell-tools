#!/usr/bin/env bats

@test "alias definitions via NAME=ALIAS-COMMAND" {
    run withAliasedCommand foo=/bin/echo loud=shout --command 'foo testing this' --command 'loud this loud?'
    [ $status -eq 0 ]
    [ "$output" = "testing this
THIS LOUD?" ]
}

@test "alias definition via --alias-command" {
    run withAliasedCommand --name foo --alias-command '/bin/echo "$@"' --name loud --alias-command 'echo "$@" | tr a-z A-Z' --command 'foo testing this' --command 'loud this loud?'
    [ $status -eq 0 ]
    [ "$output" = "testing this
THIS LOUD?" ]
}

@test "alias definition via --alias" {
    run withAliasedCommand --name foo --alias /bin/echo \; --name loud --alias shout \; --command 'foo testing this' --command 'loud this loud?'
    [ $status -eq 0 ]
    [ "$output" = "testing this
THIS LOUD?" ]
}

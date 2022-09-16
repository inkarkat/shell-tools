#!/usr/bin/env bats

@test "failing alias definition via NAME=ALIAS-COMMAND" {
    run withAliasedCommand foo=/bin/echo failing=false --command 'foo testing this' --command failing
    [ $status -eq 1 ]
    [ "$output" = "testing this" ]
}

@test "failing alias definition via --alias-command" {
    run withAliasedCommand --name foo --alias-command '/bin/echo "$@"' --name failing --alias-command '(echo nono; exit 42)' --command 'foo testing this' --command failing
    [ $status -eq 42 ]
    [ "$output" = "testing this
nono" ]
}

@test "failing alias definition via --alias" {
    run withAliasedCommand --name foo --alias /bin/echo \; --name failing --alias grep --quiet '^-- does not match --$' -- "$BATS_TEST_FILENAME" \; --command 'foo testing this' --command failing
    [ $status -eq 1 ]
    [ "$output" = "testing this" ]
}

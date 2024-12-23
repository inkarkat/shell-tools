#!/usr/bin/env bats

load fixture

@test "failing alias definition via NAME=ALIAS-COMMAND" {
    run -1 withAliasedCommand foo=/bin/echo failing=false --command 'foo testing this' --command failing
    assert_output 'testing this'
}

@test "failing alias definition via --alias-command" {
    run -42 withAliasedCommand --name foo --alias-command '/bin/echo "$@"' --name failing --alias-command '(echo nono; exit 42)' --command 'foo testing this' --command failing
    assert_output - <<'EOF'
testing this
nono
EOF
}

@test "failing alias definition via --alias" {
    run -1 withAliasedCommand --name foo --alias /bin/echo \; --name failing --alias grep --quiet '^-- does not match --$' -- "$BATS_TEST_FILENAME" \; --command 'foo testing this' --command failing
    assert_output 'testing this'
}

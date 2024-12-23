#!/usr/bin/env bats

load fixture

@test "alias definitions via NAME=ALIAS-COMMAND" {
    run -0 withAliasedCommand foo=/bin/echo loud=shout --command 'foo testing this' --command 'loud this loud?'
    assert_output - <<'EOF'
testing this
THIS LOUD?
EOF
}

@test "alias definition via --alias-command" {
    run -0 withAliasedCommand --name foo --alias-command '/bin/echo "$@"' --name loud --alias-command 'echo "$@" | tr a-z A-Z' --command 'foo testing this' --command 'loud this loud?'
    assert_output - <<'EOF'
testing this
THIS LOUD?
EOF
}

@test "alias definition via --alias" {
    run -0 withAliasedCommand --name foo --alias /bin/echo \; --name loud --alias shout \; --command 'foo testing this' --command 'loud this loud?'
    assert_output - <<'EOF'
testing this
THIS LOUD?
EOF
}

#!/usr/bin/env bats

load fixture

@test "bare input through alias definition via --alias" {
    run -0 withAliasedCommand --bare --name foo --alias /bin/echo \; --name loud --alias shout \; <<<$'foo testing this\nloud this loud?'
    assert_output - <<'EOF'
testing this
THIS LOUD?
EOF
}

@test "prompted input through alias definition via --alias" {
    run -0 withAliasedCommand --name foo --alias /bin/echo \; --name loud --alias shout \; <<<$'foo testing this\nloud this loud?'
    assert_line -n 1 '$ foo testing this'
    assert_line -n 2 'testing this'
    assert_line -n 4 '$ loud this loud?'
    assert_line -n 5 'THIS LOUD?'
    assert_equal ${#lines[@]} 7
}

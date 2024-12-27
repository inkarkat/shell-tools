#!/usr/bin/env bats

load fixture

@test "exits with 1 and no output if no input" {
    run -1 filterExpr -- false < /dev/null
    assert_output ''
}

@test "exits with 1 if no command invocation succeeds" {
    run -1 filterExpr -- false <<< $'1 foo\n44 bar\n12 baz\n33 quux'
    assert_output ''
}

@test "simplecommand with appended arg" {
    run -0 filterExpr -- test 22 -lt <<< $'1 foo\n44 bar\n12 baz\n33 quux'
    assert_output - <<'EOF'
bar
quux
EOF
}

@test "simplecommand with arg placeholder" {
    run -0 filterExpr -- test {} -gt 22 <<< $'1 foo\n44 bar\n12 baz\n33 quux'
    assert_output - <<'EOF'
bar
quux
EOF
}

#!/usr/bin/env bats

load fixture

@test "simplecommand keeps the argument" {
    run -0 filterExpr --keep-arg -- test 22 -lt <<< $'1 foo\n44 bar\n12 baz\n33 quux'
    assert_output - <<'EOF'
44 bar
33 quux
EOF
}

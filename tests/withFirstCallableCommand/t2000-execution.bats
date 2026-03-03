#!/usr/bin/env bats

load fixture

@test "first passed candidate is executed" {
    run -0 withFirstCallableCommand --candidate commandAlpha --candidate commandBeta
    assert_output 'alpha'
}

@test "second passed candidate is executed" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha --candidate commandBeta
    assert_output 'alpha'
}

@test "passed candidate is executed and its exit status returned" {
    run -42 withFirstCallableCommand --candidate doesNotExist --candidate commandBeta
    assert_output 'beta'
}

@test "second passed candidate is executed within SIMPLECOMMAND" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha one two 'and three'
    assert_output 'alpha-one-two-and three'
}

@test "second passed candidate is executed within -c COMMANDLINE" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha -c 'one two and\ three'
    assert_output 'alpha-one-two-and three'
}

@test "second passed candidate is executed within --exec SIMPLECOMMAND ;" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha --exec one two 'and three' \;
    assert_output 'alpha-one-two-and three'
}

@test "candidate is prepended to the first given COMMAND; following COMMANDs are taken as full commands" {
    run -0 withFirstCallableCommand --candidate commandAlpha --exec one two 'and three' \; -c 'echo second command' -- echo third command
    assert_output - <<'EOF'
alpha-one-two-and three
second command
third command
EOF
}

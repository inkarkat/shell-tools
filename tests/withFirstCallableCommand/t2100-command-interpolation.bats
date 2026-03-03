#!/usr/bin/env bats

load fixture

@test "second passed candidate is executed within SIMPLECOMMAND with explicit marker" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha {} one two 'and three'
    assert_output 'alpha-one-two-and three'
}

@test "second passed candidate is executed within -c COMMANDLIN with explicit marker" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha -c '{} one two and\ three'
    assert_output 'alpha-one-two-and three'
}

@test "second passed candidate is executed within --exec SIMPLECOMMAND ; with explicit marker" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha --exec {} one two 'and three' \;
    assert_output 'alpha-one-two-and three'
}

@test "second passed candidate is executed within SIMPLECOMMAND by wrapper through explicit marker" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha wrapper {} one two 'and three'
    assert_output '[alpha-one-two-and three]'
}

@test "second passed candidate is executed within -c COMMANDLIN by wrapper through explicit marker" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha -c 'wrapper {} one two and\ three'
    assert_output '[alpha-one-two-and three]'
}

@test "second passed candidate is executed within --exec SIMPLECOMMAND ; by wrapper through explicit marker" {
    run -0 withFirstCallableCommand --candidate doesNotExist --candidate commandAlpha --exec wrapper {} one two 'and three' \;
    assert_output '[alpha-one-two-and three]'
}

@test "candidate is prepended to all given COMMANDs via explicit markers" {
    run -0 withFirstCallableCommand --candidate commandAlpha --exec {} one two 'and three' \; -c '{} second command' -- {} third command
    assert_output - <<'EOF'
alpha-one-two-and three
alpha-second-command
alpha-third-command
EOF
}

#!/usr/bin/env bats

load fixture

@test "first passed custom candidate is executed" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha \; --custom-candidate commandBeta \;
    assert_output 'alpha'
}

@test "second passed custom candidate is executed" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandAlpha \; --custom-candidate commandBeta \;
    assert_output 'alpha'
}

@test "mix of custom and plain command candidates executes custom candidate" {
    run -0 withFirstCallableCommand --candidate doesNotExist --custom-candidate commandAlpha \; --candidate commandBeta
    assert_output 'alpha'
}

@test "mix of custom and plain command candidates executes plain command candidate" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --candidate commandAlpha --custom-candidate commandBeta \;
    assert_output 'alpha'
}


@test "passed custom candidate is executed and its exit status returned" {
    run -42 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandBeta \;
    assert_output 'beta'
}

@test "second passed custom candidate is executed within SIMPLECOMMAND" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandAlpha \; one two 'and three'
    assert_output 'alpha-one-two-and three'
}

@test "second passed custom candidate is executed within -c COMMANDLINE" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandAlpha \; -c 'one two and\ three'
    assert_output 'alpha-one-two-and three'
}

@test "second passed custom candidate is executed within --exec SIMPLECOMMAND ;" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandAlpha \; --exec one two 'and three' \;
    assert_output 'alpha-one-two-and three'
}

@test "custom candidate is prepended to the first given COMMAND; following COMMANDs are taken as full commands" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha \; --exec one two 'and three' \; -c 'echo second command' -- echo third command
    assert_output - <<'EOF'
alpha-one-two-and three
second command
third command
EOF
}

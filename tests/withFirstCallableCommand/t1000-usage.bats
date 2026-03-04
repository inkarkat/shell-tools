#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 withFirstCallableCommand
    assert_line -n 0 'ERROR: No CANDIDATE-COMMAND(s) passed; need to pass -C|--candidate CANDIDATE-COMMAND, or -T|--custom-candidate CANDIDATE-COMMAND [CANDIDATE-ARG [...]] ;'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 withFirstCallableCommand --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 withFirstCallableCommand -h
    refute_line -n 0 -e '^Usage:'
}

@test "missing ; after --exec prints message and usage instructions" {
    run -2 withFirstCallableCommand --exec arg
    assert_line -n 0 "ERROR: --exec command must be concluded with ';'"
    assert_line -n 1 -e '^Usage:'
}

@test "missing ; after --custom-candidate prints message and usage instructions" {
    run -2 withFirstCallableCommand --custom-candidate commandAlpha
    assert_line -n 0 "ERROR: --custom-candidate|-T must be concluded with ';'"
    assert_line -n 1 -e '^Usage:'
}

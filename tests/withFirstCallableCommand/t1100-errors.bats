#!/usr/bin/env bats

load fixture

@test "single unavailable try-command prints message and fails" {
    run -4 withFirstCallableCommand --candidate doesNotExist -- echo
    assert_output 'ERROR: doesNotExist is not callable.'
}

@test "multiple unavailable try-commands prints message and fails" {
    run -4 withFirstCallableCommand --candidate doesNotExist --candidate doesnotExist2 --candidate doesNotExist3 -- echo
    assert_output 'ERROR: None of doesNotExist, doesnotExist2 or doesNotExist3 is callable.'
}

@test "unavailable try-command message can be suppressed with --ignore-missing" {
    run -4 withFirstCallableCommand --ignore-missing --candidate doesNotExist -- echo
    assert_output ''
}

@test "unavailable try-command message can be overridden with --or-message" {
    message='You cannot run these.'
    run -4 withFirstCallableCommand --or-message "$message" --candidate doesNotExist -- echo
    assert_output "$message"
}

@test "unavailable try-command message can be suppressed with empty --or-message" {
    run -4 withFirstCallableCommand --or-message '' --candidate doesNotExist -- echo
    assert_output ''
}

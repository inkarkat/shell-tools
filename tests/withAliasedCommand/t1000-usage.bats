#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 withAliasedCommand
    assert_line -n 0 'ERROR: No aliases defined.'
    assert_line -n 2 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 withAliasedCommand --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 2 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 withAliasedCommand -h
    assert_line -n 2 -e '^Usage:'
}

@test "missing --name before --alias-command prints message and usage instructions" {
    run -2 withAliasedCommand --alias-command dummy
    assert_line -n 0 'ERROR: Missing -n|--name NAME before --alias-command.'
    assert_line -n 2 -e '^Usage:'
}

@test "missing --name before --alias-command after NAME=ALIAS prints message and usage instructions" {
    run -2 withAliasedCommand first=dummy --alias-command dummy
    assert_line -n 0 'ERROR: Missing -n|--name NAME before --alias-command.'
    assert_line -n 2 -e '^Usage:'
}

@test "missing --name before --alias prints message and usage instructions" {
    run -2 withAliasedCommand --alias dummy \;
    assert_line -n 0 'ERROR: Missing -n|--name NAME before --alias.'
    assert_line -n 2 -e '^Usage:'
}

@test "missing --alias conclusion with ; prints message and usage instructions" {
    run -2 withAliasedCommand --name foo --alias dummy
    assert_line -n 0 "ERROR: --alias command must be concluded with ';'"
    assert_line -n 2 -e '^Usage:'
}

@test "duplicate alias definition via the same way prints message and usage instructions" {
    run -2 withAliasedCommand foo=dummy bar=lala foo=again
    assert_output "ERROR: Duplicate alias 'foo'."
}

@test "duplicate alias definition via different ways prints message and usage instructions" {
    run -2 withAliasedCommand --name foo --alias first dummy \; --name foo --alias-command again
    assert_output "ERROR: Duplicate alias 'foo'."
}

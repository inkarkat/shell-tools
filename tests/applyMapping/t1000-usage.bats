#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 applyMapping
    assert_line -n 0 'ERROR: No MAPPING-FILE passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "just --mapping-file prints message and usage instructions" {
    run -2 applyMapping --mapping-file irrelevant.tsv
    assert_line -n 0 'ERROR: No FILE(s) or COMMAND(s) specified; need to pass -f|--file FILE, or -c|--command "COMMANDLINE", or --exec SIMPLECOMMAND [...] ; or SIMPLECOMMAND.'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 applyMapping --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "-h prints long usage help" {
    run -0 applyMapping -h
    refute_line -n 0 -e '^Usage:'
}

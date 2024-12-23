#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 processPassedYears
    assert_line -n 0 'ERROR: No -i|--id ID passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 processPassedYears --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "missing commands prints message and usage instructions" {
    run -2 processPassedYears --id ID
    assert_line -n 0 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or SIMPLECOMMAND.'
    assert_line -n 1 -e '^Usage:'
}

@test "use of both initial-first and initial-last prints message and usage instructions" {
    run -2 processPassedYears --id ID --initial-first 1 --initial-last 1
    assert_line -n 0 'ERROR: Only one of --initial-first or --initial-last can be passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "use of both max-first and max-last prints message and usage instructions" {
    run -2 processPassedYears --id ID --max-first 1 --max-last 1
    assert_line -n 0 'ERROR: Only one of --max-first or --max-last can be passed.'
    assert_line -n 1 -e '^Usage:'
}

#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 processAddedFiles
    assert_line -n 0 'ERROR: No -i|--id ID passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 processAddedFiles --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n 1 -e '^Usage:'
}

@test "missing commands prints message and usage instructions" {
    run -2 processAddedFiles --id ID
    assert_line -n 0 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or SIMPLECOMMAND.'
    assert_line -n 1 -e '^Usage:'
}

@test "use of both after and newer prints message and usage instructions" {
    run -2 processAddedFiles --id ID --after --newer
    assert_line -n 0 'ERROR: Only one of -a|--after or -N|--newer can be passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "use of both initial-first and initial-last prints message and usage instructions" {
    run -2 processAddedFiles --id ID --after --initial-first 1 --initial-last 1
    assert_line -n 0 'ERROR: Only one of --initial-first or --initial-last can be passed.'
    assert_line -n 1 -e '^Usage:'
}

@test "use of both max-first and max-last prints message and usage instructions" {
    run -2 processAddedFiles --id ID --after --max-first 1 --max-last 1
    assert_line -n 0 'ERROR: Only one of --max-first or --max-last can be passed.'
    assert_line -n 1 -e '^Usage:'
}

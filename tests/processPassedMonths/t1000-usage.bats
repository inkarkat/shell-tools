#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run processPassedMonths
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: No -i|--id ID passed." ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run processPassedMonths --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "missing commands prints message and usage instructions" {
    run processPassedMonths --id ID
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or SIMPLECOMMAND.' ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "use of both initial-first and initial-last prints message and usage instructions" {
    run processPassedMonths --id ID --initial-first 1 --initial-last 1
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Only one of --initial-first or --initial-last can be passed." ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

@test "use of both max-first and max-last prints message and usage instructions" {
    run processPassedMonths --id ID --max-first 1 --max-last 1
    [ $status -eq 2 ]
    [ "${lines[0]}" = "ERROR: Only one of --max-first or --max-last can be passed." ]
    [ "${lines[1]%% *}" = 'Usage:' ]
}

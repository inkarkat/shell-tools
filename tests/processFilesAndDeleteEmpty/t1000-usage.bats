#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run processFilesAndDeleteEmpty
    [ $status -eq 2 ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run processFilesAndDeleteEmpty --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

@test "missing FILE prints message and usage instructions" {
    run processFilesAndDeleteEmpty --exec true \; --
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No FILE(s) to process.' ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

@test "--exec without ; prints message and usage instructions" {
    run processFilesAndDeleteEmpty --exec true
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: --exec command must be concluded with ;!' ]
    [ "${lines[-1]%% *}" = 'Usage:' ]
}

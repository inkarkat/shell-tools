#!/usr/bin/env bats

load fixture

@test "no arguments prints message and usage instructions" {
    run -2 processFilesAndDeleteEmpty
    assert_line -n -1 -e '^Usage:'
}

@test "invalid option prints message and usage instructions" {
    run -2 processFilesAndDeleteEmpty --invalid-option
    assert_line -n 0 'ERROR: Unknown option "--invalid-option"!'
    assert_line -n -1 -e '^Usage:'
}

@test "missing FILE prints message and usage instructions" {
    run -2 processFilesAndDeleteEmpty --exec true \; --
    assert_line -n 0 'ERROR: No FILE(s) to process.'
    assert_line -n -1 -e '^Usage:'
}

@test "--exec without ; prints message and usage instructions" {
    run -2 processFilesAndDeleteEmpty --exec true
    assert_line -n 0 "ERROR: --exec command must be concluded with ';'"
    assert_line -n -1 -e '^Usage:'
}

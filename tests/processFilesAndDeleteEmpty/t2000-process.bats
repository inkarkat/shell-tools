#!/usr/bin/env bats

load fixture

@test "change two files" {
    run processFilesAndDeleteEmpty --exec "${changeAllCommand[@]}" \; -- "$FILE1" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assertFile1Changed
    assertFile2Changed
}

@test "change first delete second file" {
    run processFilesAndDeleteEmpty --exec "${changeAndDeleteCommand[@]}" \; -- "$FILE1" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assertFile1Changed
    assertFile2Deleted
}

@test "delete two files" {
    run processFilesAndDeleteEmpty --exec "${deleteAllCommand[@]}" \; -- "$FILE1" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    assertFile1Deleted
    assertFile2Deleted
}

@test "delete first fail on second file" {
    run processFilesAndDeleteEmpty --exec "${deleteAndFailCommand[@]}" \; -- "$FILE1" "$FILE2"
    [ $status -eq 1 ]
    [ "$output" = "" ]
    ! assertFile1Unchanged
    ! assertFile1Deleted
    assertFile2Unchanged
}

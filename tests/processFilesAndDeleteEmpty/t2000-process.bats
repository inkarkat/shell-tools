#!/usr/bin/env bats

load fixture

@test "change two files" {
    run -0 processFilesAndDeleteEmpty --exec "${changeAllCommand[@]}" \; -- "$FILE1" "$FILE2"
    assert_output ''
    assertFile1Changed
    assertFile2Changed
}

@test "change first delete second file" {
    run -0 processFilesAndDeleteEmpty --exec "${changeAndDeleteCommand[@]}" \; -- "$FILE1" "$FILE2"
    assert_output ''
    assertFile1Changed
    assertFile2Deleted
}

@test "delete two files" {
    run -0 processFilesAndDeleteEmpty --exec "${deleteAllCommand[@]}" \; -- "$FILE1" "$FILE2"
    assert_output ''
    assertFile1Deleted
    assertFile2Deleted
}

@test "delete first fail on second file" {
    run -1 processFilesAndDeleteEmpty --exec "${deleteAndFailCommand[@]}" \; -- "$FILE1" "$FILE2"
    assert_output ''
    ! assertFile1Unchanged
    ! assertFile1Deleted
    assertFile2Unchanged
}

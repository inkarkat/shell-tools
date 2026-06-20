#!/usr/bin/env bats

load fixture

typeset -gra CHANGE_ALL_COMMAND=(sed -i -e 's/[oO]\+/i/g')
typeset -gra CHANGE_AND_DELETE_COMMAND=(sed -i -e 's/[oO]\+/i/g' -e '/x/d')
typeset -gra DELETE_ALL_COMMAND=(sed -i -e '/[oO]/d')
typeset -gra DELETE_AND_FAIL_COMMAND=(sed -i -e '/O/d' -e '/o/q 1')

@test "change two files" {
    run -0 processFilesAndDeleteEmpty --exec "${CHANGE_ALL_COMMAND[@]}" \; -- "$FILE1" "$FILE2"
    assert_output ''
    assertFile1Changed
    assertFile2Changed
}

@test "change first delete second file" {
    run -0 processFilesAndDeleteEmpty --exec "${CHANGE_AND_DELETE_COMMAND[@]}" \; -- "$FILE1" "$FILE2"
    assert_output ''
    assertFile1Changed
    assertFile2Deleted
}

@test "delete two files" {
    run -0 processFilesAndDeleteEmpty --exec "${DELETE_ALL_COMMAND[@]}" \; -- "$FILE1" "$FILE2"
    assert_output ''
    assertFile1Deleted
    assertFile2Deleted
}

@test "delete first fail on second file" {
    run -1 processFilesAndDeleteEmpty --exec "${DELETE_AND_FAIL_COMMAND[@]}" \; -- "$FILE1" "$FILE2"
    assert_output ''
    ! assertFile1Unchanged
    ! assertFile1Deleted
    assertFile2Unchanged
}

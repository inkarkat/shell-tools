#!/usr/bin/env bats

load fixture

@test "invalid number of bytes to split fails without invoking commands" {
    LANG=C run -1 eachSplit --bytes=0 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" -- exit 42
    assert_output -e "^split: invalid number of bytes: '0'"
}

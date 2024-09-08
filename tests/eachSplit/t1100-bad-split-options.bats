#!/usr/bin/env bats

@test "invalid number of bytes to split fails without invoking commands" {
    LANG=C run eachSplit --bytes=0 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" -- exit 42
    [ $status -eq 1 ]
    [ "$output" = "split: invalid number of bytes: '0': Numerical result out of range" ]
}

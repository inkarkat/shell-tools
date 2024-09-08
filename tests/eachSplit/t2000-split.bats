#!/usr/bin/env bats

load fixture

@test "split two-liners and prefix" {
    run eachSplit --lines=2 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    [ "$status" -eq 0 ]
    [ "$output" = 'aa: The opener
aa: Is a simple one.
ab: Secondary
ab: Is the next one.
ac: Third
ac: Aller guten Dinge sind drei.
ad: Last
ad: but not least.' ]
}

@test "split two-liners and count characters" {
    run eachSplit --lines=2 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command 'cat {} | wc --chars'
    [ "$status" -eq 0 ]
    [ "$output" = '28
27
35
20' ]
}

@test "split two-liners and exit with character count, giving the highest count" {
    run eachSplit --lines=2 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(exit $(cat {} | wc --chars)) #'
    [ "$status" -eq 35 ]
    [ "$output" = "" ]
}

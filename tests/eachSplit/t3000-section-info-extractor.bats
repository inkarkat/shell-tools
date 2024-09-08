#!/usr/bin/env bats

load fixture

@test "split two-liners with header that has custom section info extractor" {
    run eachSplit --lines=2 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --with-header --section-info-extractor head -n 1 -- \; -- "${SECTION_PREFIXER_COMMAND[@]}"
    [ "$status" -eq 0 ]
    [ "$output" = 'The opener:
aa: The opener
aa: Is a simple one.

Secondary:
ab: Secondary
ab: Is the next one.

Third:
ac: Third
ac: Aller guten Dinge sind drei.

Last:
ad: Last
ad: but not least.' ]
}

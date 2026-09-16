#!/usr/bin/env bats

load fixture

@test "split two-liners with header that has custom piece info extractor" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --with-header --piece-info-extractor-exec head -n 1 -- \; -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
The opener:
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
ad: but not least.
EOF
}

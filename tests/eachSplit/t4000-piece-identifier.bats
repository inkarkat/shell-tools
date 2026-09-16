#!/usr/bin/env bats

load fixture

typeset -gra PIECE_PREFIXER_COMMAND=(sed -e 's#^#{I}: #')

@test "split two-liners and prefix with default piece identifier" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
piece-aa: The opener
piece-aa: Is a simple one.
piece-ab: Secondary
piece-ab: Is the next one.
piece-ac: Third
piece-ac: Aller guten Dinge sind drei.
piece-ad: Last
piece-ad: but not least.
EOF
}

@test "split two-liners and prefix with piece identifier from custom piece info extractor" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --piece-info-extractor-exec head -n 1 -- \; -- "${PIECE_PREFIXER_COMMAND[@]}" {}
    assert_output - <<'EOF'
The opener: The opener
The opener: Is a simple one.
Secondary: Secondary
Secondary: Is the next one.
Third: Third
Third: Aller guten Dinge sind drei.
Last: Last
Last: but not least.
EOF
}

#!/usr/bin/env bats

load fixture

typeset -gra PIECE_MODIFIER_ARGS=(--piece-modifier-exec sed -i -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' -- \;)

@test "split two-liners with piece modifier that uppercases the text" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" "${PIECE_MODIFIER_ARGS[@]}" -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
aa: THE OPENER
aa: IS A SIMPLE ONE.
ab: SECONDARY
ab: IS THE NEXT ONE.
ac: THIRD
ac: ALLER GUTEN DINGE SIND DREI.
ad: LAST
ad: BUT NOT LEAST.
EOF
}

@test "split two-liners with header that has custom piece info extractor and piece modifier that uppercases the text" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --with-header --piece-info-extractor-exec head -n 1 -- \; "${PIECE_MODIFIER_ARGS[@]}" -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
The opener:
aa: THE OPENER
aa: IS A SIMPLE ONE.

Secondary:
ab: SECONDARY
ab: IS THE NEXT ONE.

Third:
ac: THIRD
ac: ALLER GUTEN DINGE SIND DREI.

Last:
ad: LAST
ad: BUT NOT LEAST.
EOF
}

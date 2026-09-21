#!/usr/bin/env bats

load fixture

typeset -gra PIECE_UPPERCASE_COMMAND=(sed -i -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' --)
typeset -gra PIECE_MODIFIER_ARGS=(--piece-modifier-exec "${PIECE_UPPERCASE_COMMAND[@]}" \;)

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

@test "split two-liners with piece modifier that filters out some pieces" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --piece-modifier-exec grep -e opener -e Dinge \; -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
The opener
aa: The opener
aa: Is a simple one.
Aller guten Dinge sind drei.
ac: Third
ac: Aller guten Dinge sind drei.
EOF
}

@test "split two-liners with two piece modifiers that filter out some pieces and uppercases what's left" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" \
	--piece-modifier-exec "${PIECE_UPPERCASE_COMMAND[@]}" {} \; \
	--piece-modifier-exec grep -e OPENER -e DINGE {} \; \
	-- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
THE OPENER
aa: THE OPENER
aa: IS A SIMPLE ONE.
ALLER GUTEN DINGE SIND DREI.
ac: THIRD
ac: ALLER GUTEN DINGE SIND DREI.
EOF
}

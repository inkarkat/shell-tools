#!/usr/bin/env bats

load fixture

@test "splitting pieces with --elide-first omits first file" {
    run -0 eachCsplit --elide-first --quiet --suppress-matched '/^--$/' '{*}' --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
01: Secondary
01: Is the next one
01: and has more text.
02: Third
02: Aller
02: guten
02: Dinge
02: sind
02: drei.
03: Last but not least.
EOF
}

@test "splitting pieces with --elide-last omits last file" {
    run -0 eachCsplit --elide-last --quiet --suppress-matched '/^--$/' '{*}' --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
00: The opener
00: Is a simple one.
01: Secondary
01: Is the next one
01: and has more text.
02: Third
02: Aller
02: guten
02: Dinge
02: sind
02: drei.
EOF
}

@test "splitting pieces with both --elide-first and --elide-last omits first and last files" {
    run -0 eachCsplit --elide-first --elide-last --quiet --suppress-matched '/^--$/' '{*}' --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
01: Secondary
01: Is the next one
01: and has more text.
02: Third
02: Aller
02: guten
02: Dinge
02: sind
02: drei.
EOF
}

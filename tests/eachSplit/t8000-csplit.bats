#!/usr/bin/env bats

load fixture

@test "csplit dashdash delimited file" {
    run -0 eachCsplit --suppress-matched '/^--$/' '{*}' --input "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
28
45
35
20
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
03: Last but not least.
EOF
}

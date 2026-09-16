#!/usr/bin/env bats

load fixture

@test "split dashdash-delimited sections with header that has custom section info extractor" {
    run -0 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --with-header --section-info-extractor-command 'printf "%d line(s)" "$(cat -- {} | wc -l)"' -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
2 line(s):
00: The opener
00: Is a simple one.

3 line(s):
01: Secondary
01: Is the next one
01: and has more text.

6 line(s):
02: Third
02: Aller
02: guten
02: Dinge
02: sind
02: drei.

1 line(s):	03: Last but not least.
EOF
}

@test "split dashdash-delimited sections with header that has custom section info extractor and includes the separator" {
    run -0 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --with-header --section-info-extractor-command 'printf "%d line(s)" "$(cat -- {} | wc -l)"' --section-info-include-separator -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
2 line(s):
00: The opener
00: Is a simple one.

4 line(s):
01: Secondary
01: Is the next one
01: and has more text.

7 line(s):
02: Third
02: Aller
02: guten
02: Dinge
02: sind
02: drei.

2 line(s):	03: Last but not least.
EOF
}

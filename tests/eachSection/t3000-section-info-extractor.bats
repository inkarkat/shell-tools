#!/usr/bin/env bats

load fixture

@test "split dashdash-delimited sections with header that has custom section info extractor" {
    run -0 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --with-header --section-info-extractor-command 'printf "%d line(s)" "$(cat -- {} | wc -l)"' -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
2 line(s):
0000: The opener
0000: Is a simple one.

3 line(s):
0001: Secondary
0001: Is the next one
0001: and has more text.

6 line(s):
0002: Third
0002: Aller
0002: guten
0002: Dinge
0002: sind
0002: drei.

1 line(s):	0003: Last but not least.
EOF
}

@test "split dashdash-delimited sections with header that has custom section info extractor and includes the separator above the section" {
    run -0 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --with-header --section-info-extractor-command 'printf "%d line(s)" "$(cat -- {} | wc -l)"' --section-info-include-separator above -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
2 line(s):
0000: The opener
0000: Is a simple one.

4 line(s):
0001: Secondary
0001: Is the next one
0001: and has more text.

7 line(s):
0002: Third
0002: Aller
0002: guten
0002: Dinge
0002: sind
0002: drei.

2 line(s):	0003: Last but not least.
EOF
}

@test "split dashdash-delimited sections with header that has custom section info extractor and includes the separator below the section" {
    run -0 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --with-header --section-info-extractor-command 'printf "%d line(s)" "$(cat -- {} | wc -l)"' --section-info-include-separator below -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
3 line(s):
0000: The opener
0000: Is a simple one.

4 line(s):
0001: Secondary
0001: Is the next one
0001: and has more text.

7 line(s):
0002: Third
0002: Aller
0002: guten
0002: Dinge
0002: sind
0002: drei.

1 line(s):	0003: Last but not least.
EOF
}

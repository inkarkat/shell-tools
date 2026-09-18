#!/usr/bin/env bats

load fixture

@test "split dashdash-delimited sections and prefix" {
    run -0 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
0000: The opener
0000: Is a simple one.
0001: Secondary
0001: Is the next one
0001: and has more text.
0002: Third
0002: Aller
0002: guten
0002: Dinge
0002: sind
0002: drei.
0003: Last but not least.
EOF
}

@test "split dashdash-delimited sections and count characters" {
    run -0 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --command 'cat {} | wc --chars'
    assert_output - <<'EOF'
28
45
35
20
EOF
}

@test "split dashdash-delimited sections and exit with character count, giving the highest count" {
    run -45 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --command '(exit $(cat {} | wc --chars)) #'
    assert_output ''
}

@test "split dashdash-headered sections and prefix" {
    run -0 eachSection --section-separator '^-- [^[:space:]].* --\+$' --file "${BATS_TEST_DIRNAME}/inputs/dashdash-headered.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
0001: Is a simple one.
0001: 
0002: Is the next one
0002: 
0002: and has more text.
0002: 
0003: Aller
0003: guten
0003: Dinge
0003: sind
0003: drei.
0003: 
0003: 
0004: Last but not least.
EOF
}

@test "split footered sections and prefix" {
    run -0 eachSection --section-separator '|[0-9]\{2\}-\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)-[0-9]\{4\} [0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\} ![0-9]\+ *$' --file "${BATS_TEST_DIRNAME}/inputs/footered.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
0000: Is a simple one.
0001: Is the next one
0001: 
0001: and has more text.
0002: Aller
0002: guten
0002: Dinge
0002: sind
0002: drei.
0003: Last but not least.
EOF
}

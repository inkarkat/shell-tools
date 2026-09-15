#!/usr/bin/env bats

load fixture

@test "split dashdash-delimited sections and prefix" {
    run -0 eachSection --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
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
03: Last but not least.
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

@test "split headered sections and prefix" {
    run -0 eachSection --section-separator '^-- [^[:space:]].* -\+$' --file "${BATS_TEST_DIRNAME}/inputs/headered.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
01: Is a simple one.
01: 
02: Is the next one
02: 
02: and has more text.
02: 
03: Aller
03: guten
03: Dinge
03: sind
03: drei.
03: 
03: 
04: Last but not least.
EOF
}

@test "split footered sections and prefix" {
    run -0 eachSection --section-separator '|[0-9]\{2\}-\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)-[0-9]\{4\} [0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\} ![0-9]\+ *$' --file "${BATS_TEST_DIRNAME}/inputs/footered.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
00: Is a simple one.
01: Is the next one
01: 
01: and has more text.
02: Aller
02: guten
02: Dinge
02: sind
02: drei.
03: Last but not least.
EOF
}

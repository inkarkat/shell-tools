#!/usr/bin/env bats

load fixture

@test "split paragraphs and prefix" {
    run -0 eachParagraph --file "${BATS_TEST_DIRNAME}/input.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
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

@test "split paragraphs and count characters" {
    run -0 eachParagraph --file "${BATS_TEST_DIRNAME}/input.txt" --command 'cat {} | wc --chars'
    assert_output - <<'EOF'
28
45
35
20
EOF
}

@test "split paragraphs and exit with character count, giving the highest count" {
    run -45 eachParagraph --file "${BATS_TEST_DIRNAME}/input.txt" --command '(exit $(cat {} | wc --chars)) #'
    assert_output ''
}

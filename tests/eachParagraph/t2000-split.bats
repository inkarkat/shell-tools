#!/usr/bin/env bats

load fixture

@test "split paragraphs and prefix" {
    run -0 eachParagraph --file "${BATS_TEST_DIRNAME}/input.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
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

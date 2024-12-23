#!/usr/bin/env bats

load fixture

@test "split two-liners and prefix" {
    run -0 eachSplit --lines=2 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
aa: The opener
aa: Is a simple one.
ab: Secondary
ab: Is the next one.
ac: Third
ac: Aller guten Dinge sind drei.
ad: Last
ad: but not least.
EOF
}

@test "split two-liners and count characters" {
    run -0 eachSplit --lines=2 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command 'cat {} | wc --chars'
    assert_output - <<'EOF'
28
27
35
20
EOF
}

@test "split two-liners and exit with character count, giving the highest count" {
    run -35 eachSplit --lines=2 --input "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(exit $(cat {} | wc --chars)) #'
    assert_output ''
}

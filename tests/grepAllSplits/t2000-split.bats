#!/usr/bin/env bats

load fixture

@test "split two-liners piece filespecs and passed COMMAND-ARGS are grepped" {
    run -0 grepAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --line-number -e '^T'
    assert_output - <<'EOF'
piece-aa:1:The opener
piece-ac:1:Third
EOF
}

@test "split two-liners piece filespecs and passed COMMAND-ARGS are grepped for non-existing pattern" {
    run -1 grepAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --line-number -e 'doesNotExist'
    assert_output ''
}

@test "on empty input, grep is not run at all" {
    COMMANDONALLSPLITS_COMMAND=echo run -99 grepAllSplits --lines=2 --file /dev/null
    assert_output ''
}

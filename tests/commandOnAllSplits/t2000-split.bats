#!/usr/bin/env bats

load fixture

@test "split two-liners piece filespecs are appended to command" {
    COMMANDONALLSPLITS_COMMAND=echo run -0 commandOnAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt"
    assert_output 'piece-aa piece-ab piece-ac piece-ad'
}

@test "split two-liners piece filespecs and passed COMMAND-ARGS are appended to command" {
    COMMANDONALLSPLITS_COMMAND=grep run -0 commandOnAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" -nh -e '^' --
    assert_output - <<'EOF'
1:The opener
2:Is a simple one.
1:Secondary
2:Is the next one.
1:Third
2:Aller guten Dinge sind drei.
1:Last
2:but not least.
EOF
}

@test "on empty input, the consumer command is not run at all" {
    COMMANDONALLSPLITS_COMMAND=echo run -99 commandOnAllSplits --lines=2 --file /dev/null
    assert_output ''
}

#!/usr/bin/env bats

load fixture

@test "split two-liners piece filespecs are appended to command" {
    run -0 onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --exec grep -nh -e '^' -- \;
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

@test "split two-liners piece catalog filespec is inserted at {C} marker" {
    run -0 onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --exec xargs --arg-file {C} -d '\n' -n 1 grep -nh -e '^' -- \;
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

@test "split two-liners piece glob is inserted at {G} marker" {
    run -0 onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command "grep -nh -e '^' -- {G}"
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
    run -99 onAllSplits --lines=2 --file /dev/null --exec echo 'I got these pieces:' '{G}' \;
    assert_output ''
}

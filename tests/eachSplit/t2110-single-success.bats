#!/usr/bin/env bats

load fixture

@test "split two-liners exits with the highest number of English words" {
    run -2 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(exit $(grep --count -i -e the -e is -e not -- {}))'
    assert_output ''
}

@test "split two-liners with --single-success exits with 0 due to the German split" {
    run -0 eachSplit --single-success --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(exit $(grep --count -i -e the -e is -e not -- {}))'
    assert_output ''
}

@test "split two-liners with --single-success --status-99-is-noop exits with 1" {
    run -1 eachSplit --single-success --status-99-is-noop --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(grep --quiet -i -e the -e is -e not -- {} && exit 99)'
    assert_output ''
}

@test "split two-liners --with-header can be combined with --single-success" {
    run -0 eachSplit --with-header --single-success --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command 'cat'
    assert_output - <<'EOF'
piece-aa:
The opener
Is a simple one.

piece-ab:
Secondary
Is the next one.

piece-ac:
Third
Aller guten Dinge sind drei.

piece-ad:
Last
but not least.
EOF
}

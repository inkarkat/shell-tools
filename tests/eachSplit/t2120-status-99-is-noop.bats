#!/usr/bin/env bats

load fixture

@test "split two-liners with --single-success --status-99-is-noop exits with 0 if one invocation succeeds" {
    run -0 eachSplit --status-99-is-noop --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(grep --quiet -i -e the -e is -e not -- {} || exit 99)'
    assert_output ''
}

@test "split two-liners with --single-success --status-99-is-noop exits with 1 if one invocation fails" {
    run -1 eachSplit --status-99-is-noop --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(grep --quiet -i -e the -e is -e not -- {} && exit 99)'
    assert_output ''
}

@test "split two-liners with --single-success --status-99-is-noop exits with 99 if all invocation exit with 99" {
    run -99 eachSplit --status-99-is-noop --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(echo {} >/dev/null; exit 99)'
    assert_output ''
}

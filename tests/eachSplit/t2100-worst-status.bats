#!/usr/bin/env bats

load fixture

@test "split two-liners exits with the highest number of characters" {
    run -35 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(exit $(cat {} | wc --chars))'
    assert_output ''
}

@test "split two-liners while forcing runWith exits with the last number of characters" {
    run -20 eachSplit --exit-on 127 --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(exit $(cat {} | wc --chars))'
    assert_output ''
}

@test "split two-liners while forcing runWith needs --worst-status to exit with the highest number of characters" {
    run -35 eachSplit --exit-on 127 --worst-status --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(exit $(cat {} | wc --chars))'
    assert_output ''
}

@test "split two-liners with --worst-status --status-99-is-noop exits with 1" {
    run -1 eachSplit --worst-status --status-99-is-noop --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --command '(grep --quiet -i -e the -e is -e not -- {} && exit 99)'
    assert_output ''
}

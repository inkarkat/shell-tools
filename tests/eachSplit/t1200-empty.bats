#!/usr/bin/env bats

load fixture

@test "exits with 99 on empty input" {
    run -99 eachSplit --lines=2 --file /dev/null -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output ''
}

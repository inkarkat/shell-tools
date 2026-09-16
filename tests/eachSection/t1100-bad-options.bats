#!/usr/bin/env bats

load fixture

@test "unsupported EACHHEADER_STYLE value prints error and exits with 2" {
    EACHHEADER_STYLE=doesNotExist run -2 eachHeader --file "${BATS_TEST_DIRNAME}/inputs/headered.txt" -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output 'ERROR: Unknown header style "doesNotExist".'
}

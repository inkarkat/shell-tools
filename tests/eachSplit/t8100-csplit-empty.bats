#!/usr/bin/env bats

load fixture

@test "splitting empty input does not invoke the command" {
    run eachCsplit --quiet --elide-empty-files --suppress-matched '/^--$/' '{*}' --input /dev/null -- echo WHAT
    [ "$status" -eq 0 ]
    [ "$output" = '' ]
}

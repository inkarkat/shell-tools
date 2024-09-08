#!/usr/bin/env bats

load fixture

@test "splitting empty input does not invoke the command and exits with 99" {
    run eachCsplit --quiet --elide-empty-files --suppress-matched '/^--$/' '{*}' --input /dev/null -- echo WHAT
    [ "$status" -eq 99 ]
    [ "$output" = '' ]
}

@test "splitting empty input with prompt does not invoke the command and exits with 99" {
    run eachCsplit --with-prompt --quiet --elide-empty-files --suppress-matched '/^--$/' '{*}' --input /dev/null -- echo WHAT
    [ "$status" -eq 99 ]
    [ "$output" = '' ]
}

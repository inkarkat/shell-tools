#!/usr/bin/env bats

load fixture

@test "splitting empty input does not invoke the command and exits with 99" {
    run -99 eachCsplit --quiet --elide-empty-files --suppress-matched '/^--$/' '{*}' --input /dev/null -- echo WHAT
    assert_output ''
}

@test "splitting empty input with prompt does not invoke the command and exits with 99" {
    run -99 eachCsplit --with-prompt --quiet --elide-empty-files --suppress-matched '/^--$/' '{*}' --input /dev/null -- echo WHAT
    assert_output ''
}

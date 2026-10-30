#!/usr/bin/env bats

load fixture

@test "no arguments and no COMMAND prints message and usage instructions" {
    run -2 commandOnAllSplits
    assert_output 'ERROR: COMMANDONALLSPLITS_COMMAND is not set.'
}

@test "incomplete eachSplit option prints message and usage instructions" {
    COMMANDONALLSPLITS_COMMAND=false run -2 commandOnAllSplits --piece-info-extractor-exec notEndedWithSemicolon
    assert_line -n 0 "ERROR: --piece-info-extractor-exec command must be concluded with ';'"
    assert_line -n 1 -e '^Usage:'
}

@test "-h prints long usage help" {
    COMMANDONALLSPLITS_COMMAND=false run -0 commandOnAllSplits -h
    refute_line -n 0 -e '^Usage:'
}

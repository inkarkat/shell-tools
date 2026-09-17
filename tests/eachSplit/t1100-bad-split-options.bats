#!/usr/bin/env bats

load fixture

@test "invalid number of bytes to split fails without invoking commands" {
    LANG=C run -1 eachSplit --bytes=0 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" -- exit 42
    assert_output -e "^split: invalid number of bytes: '0'"
}

@test "no command nor consumer-command prints error and exits with 2" {
    run -2 eachSplit --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt"
    assert_line -n 0 'ERROR: No COMMAND(s) specified; need to pass -c|--command "COMMANDLINE", or --exec SIMPLECOMMAND [...] ;, or -C|--consumer-command "COMMANDLINE", or --consumer-exec SIMPLECOMMAND [...] ; or SIMPLECOMMAND.'
}

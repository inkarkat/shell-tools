#!/usr/bin/env bats

load fixture

@test "splitting empty input invokes the command once" {
    run -0 eachSection --file /dev/null -- echo WHAT
    assert_output -e '^WHAT .*/section-0000$'
}

@test "splitting empty input with --elide-empty-files does not invoke the command and exits with 99" {
    run -99 eachSection --elide-empty-files --file /dev/null -- echo WHAT
    assert_output ''
}

@test "splitting empty input with --elide-empty-files and prompt does not invoke the command and exits with 99" {
    run -99 eachSection --elide-empty-files --with-prompt --file /dev/null -- echo WHAT
    assert_output ''
}

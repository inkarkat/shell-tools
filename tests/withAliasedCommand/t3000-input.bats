#!/usr/bin/env bats

inputWrapper()
{
    local input="$1"; shift
    printf "%s${input:+\n}" "$input" | "$@"
}
runWithInput()
{
    run inputWrapper "$@"
}

@test "bare input through alias definition via --alias" {
    runWithInput $'foo testing this\nloud this loud?' withAliasedCommand --bare --name foo --alias /bin/echo \; --name loud --alias shout \;
    [ $status -eq 0 ]
    [ "$output" = "testing this
THIS LOUD?" ]
}

@test "prompted input through alias definition via --alias" {
    runWithInput $'foo testing this\nloud this loud?' withAliasedCommand --name foo --alias /bin/echo \; --name loud --alias shout \;
    [ $status -eq 0 ]
    [ "${lines[1]}" = '$ foo testing this' ]
    [ "${lines[2]}" = 'testing this' ]
    [ "${lines[4]}" = '$ loud this loud?' ]
    [ "${lines[5]}" = 'THIS LOUD?' ]
    [ "${#lines[@]}" = 7 ]
}

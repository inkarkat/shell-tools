#!/usr/bin/env bats

load fixture

@test "alias definition via --alias-command" {
    run -0 withAliasedCommand --name special --alias-command 'echo Go "$1-$2" for "$3" and "$2": "$*"' -- special one two three
    assert_output 'Go one-two for three and two: one two three'
}

@test "quoting in alias definition via --alias-command" {
    run -0 withAliasedCommand --name special --alias-command 'echo Go "$1-$2" for "$3" and "$2": "$*"' -- special 'the one' '/two\' "th'ee"
    assert_output 'Go the one-/two\ for th'\''ee and /two\: the one /two\ th'\''ee'
}

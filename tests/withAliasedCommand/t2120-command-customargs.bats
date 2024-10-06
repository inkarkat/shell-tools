#!/usr/bin/env bats

export WITHALIASEDCOMMAND_ARG_MARKER='[X]'
@test "alias definition via placeholders in --alias" {
    run withAliasedCommand --name special --alias echo Go '[1]-[2]' for '[3] but not {3}' and '[2]:' '[*]' \; -- special one two three
    [ $status -eq 0 ]
    [ "$output" = 'Go one-two for three but not {3} and two: one two three' ]
}

@test "quoting in alias definition via --alias" {
    run withAliasedCommand --name special --alias echo Go '[1]-[2]' for '[3] but not {3}' and '[2]:' '[*]' \; -- special 'the one' '/two\' "th'ee"
    [ $status -eq 0 ]
    [ "$output" = 'Go the one-/two\ for th'\''ee but not {3} and /two\: the one /two\ th'\''ee' ]
}

#!/usr/bin/env bats

load fixture

export WITHALIASEDCOMMAND_ARG_MARKER='[X]'

@test "alias definition via placeholders in --alias" {
    run -0 withAliasedCommand --name special --alias echo Go '[1]-[2]' for '[3] but not {3}' and '[2]:' '[*]' \; -- special one two three
    assert_output 'Go one-two for three but not {3} and two: one two three'
}

@test "quoting in alias definition via --alias" {
    run -0 withAliasedCommand --name special --alias echo Go '[1]-[2]' for '[3] but not {3}' and '[2]:' '[*]' \; -- special 'the one' '/two\' "th'ee"
    assert_output 'Go the one-/two\ for th'\''ee but not {3} and /two\: the one /two\ th'\''ee'
}

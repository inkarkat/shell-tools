#!/usr/bin/env bats

load temp

@test "processing standard input works" {
    CONTENTS="# useless"
    output="$(echo "$CONTENTS" | addOrUpdateAssignment --lhs new --rhs add)"
    [ "$output" = "$CONTENTS
new=add" ]
}

@test "nonexisting file and standard input works" {
    CONTENTS="# useless"
    output="$(echo "$CONTENTS" | addOrUpdateAssignment --lhs new --rhs add "$NONE" -)"
    [ "$output" = "$CONTENTS
new=add" ]
}

@test "update in first existing file skips nonexisting files" {
    run addOrUpdateAssignment --in-place --lhs new --rhs add --update-match "foo=bar" "$NONE" "$FILE" "$NONE2" "$FILE2"
    [ $status -eq 0 ]
    [ "$output" = "" ]
    [ "$(cat "$FILE")" = "sing/e=wha\\ever
new=add
foo=hoo bar baz
# SECTION
fox=hi" ]
    cmp "$FILE2" "$MORE2"
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}

@test "all nonexisting files returns 4" {
    run addOrUpdateAssignment --in-place --lhs new --rhs add --update-match "foo=bar" "$NONE" "$NONE2"
    [ $status -eq 4 ]
    [ "$output" = "" ]
    [ ! -e "$NONE" ]
    [ ! -e "$NONE2" ]
}

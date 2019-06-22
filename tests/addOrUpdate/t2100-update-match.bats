#!/usr/bin/env bats

load temp

@test "update with nonmatching pattern appends at the end" {
    init
    UPDATE="foo=new"
    run addOrUpdate --line "$UPDATE" --update-match "foosball=never" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = "$(cat "$INPUT")
$UPDATE" ]
}

@test "update with literal-like pattern updates first matching line" {
    init
    run addOrUpdate --line "foo=new" --update-match "foo=h" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = 'sing/e=wha\ever
foo=bar
foo=new
# SECTION
foo=hi' ]
}

@test "update with anchored pattern updates first matching line" {
    init
    run addOrUpdate --line "foo=new" --update-match "^fo\+=[ghi].*$" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = 'sing/e=wha\ever
foo=bar
foo=new
# SECTION
foo=hi' ]
}

@test "update with pattern containing forward and backslash updates first matching line" {
    init
    run addOrUpdate --line 'foo=/e\' --update-match "^.*/.=.*\\.*" "$FILE"
    [ $status -eq 0 ]
    [ "$output" = 'foo=/e\
foo=bar
foo=hoo bar baz
# SECTION
foo=hi' ]
}


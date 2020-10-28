#!/usr/bin/env bats

load fixture

@test "pop the first line of the bag" {
    make_bag
    run bag --pop
    [ $status -eq 0 ]
    [ "$output" = "some stuff" ]
}

@test "pop the first line of the bag twice" {
    make_bag
    bag --pop >/dev/null
    run bag --pop
    [ $status -eq 0 ]
    [ "$output" = " in" ]
}

@test "pop two lines" {
    make_bag
    run bag --pop --lines 2
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in" ]
}
@test "pop more lines than available" {
    make_bag
    run bag --pop --lines 4
    [ $status -eq 0 ]
    [ "$output" = "some stuff
 in
here" ]
}

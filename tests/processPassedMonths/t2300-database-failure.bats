#!/usr/bin/env bats

load fixture

@test "failing to read the database does not run commands, and returns 3" {
    miniDB() {
	contains --query "$@" && return 66 || return 0
    }
    export -f miniDB

    run -3 processPassedMonths --id ID --command "printf '[%s]-'"
    assert_output ''
}

@test "failing to update the database returns 3" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    miniDB() {
	contains --update "$@" && return 1
	command miniDB "$@"
    }
    export -f miniDB

    setDate 2021-05-11
    run -3 processPassedMonths --id ID --command "printf '[%s]-'"
    assert_output '[2021-04]-'
}

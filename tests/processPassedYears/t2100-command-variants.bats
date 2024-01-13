#!/usr/bin/env bats

load fixture

@test "call two years later to simple command with explicit {}" {
    setDate 2019-04-20
    run processPassedYears --id ID -- false

    setDate 2021-06-01
    run processPassedYears --id ID -- printf '[%s]-' first '{}' last
    [ $status -eq 0 ]
    [ "$output" = "[first]-[2019]-[2020]-[last]-" ]
}

@test "call two years later to commandline" {
    setDate 2019-04-20
    run processPassedYears --id ID -- false

    setDate 2021-06-01
    run processPassedYears --id ID --command "printf '[%s]-'"
    [ $status -eq 0 ]
    [ "$output" = "[2019]-[2020]-" ]
}

@test "call two years later to commandline with explicit {}" {
    setDate 2019-04-20
    run processPassedYears --id ID -- false

    setDate 2021-06-01
    run processPassedYears --id ID --command "printf first-; printf '[%s]-' {}; printf last"
    [ $status -eq 0 ]
    [ "$output" = "first-[2019]-[2020]-last" ]
}

@test "call two years later to simple command with reconfigured [X] marker, leaving any {} intact" {
    setDate 2019-04-20
    run processPassedYears --id ID -- false

    setDate 2021-06-01
    export PROCESSPASSEDYEARS_MARKER='[X]'
    run processPassedYears --id ID -- printf '[%s]-{}-' first '[X]' last
    [ $status -eq 0 ]
    [ "$output" = "[first]-{}-[2019]-{}-[2020]-{}-[last]-{}-" ]
}

@test "call two years later to combined command-line and simple command with reconfigured [X] marker, leaving any {} intact" {
    setDate 2019-04-20
    run processPassedYears --id ID -- false

    setDate 2021-06-01
    export PROCESSPASSEDYEARS_MARKER='@@'
    run processPassedYears --id ID --command 'printf AA{}ZZ@@' -- printf '[%s]-{}-' first '@@' last
    [ $status -eq 0 ]
    [ "$output" = "AA{}ZZ2019[first]-{}-[2019]-{}-[2020]-{}-[last]-{}-" ]
}

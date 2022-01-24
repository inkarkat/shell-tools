#!/usr/bin/env bats

load fixture

@test "call two months later to simple command with explicit {}" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    run processPassedMonths --id ID -- printf '[%s]-' first '{}' last
    [ $status -eq 0 ]
    [ "$output" = "[first]-[2021-04]-[2021-05]-[last]-" ]
}

@test "call two months later to commandline" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    run processPassedMonths --id ID --command "printf '[%s]-'"
    [ $status -eq 0 ]
    [ "$output" = "[2021-04]-[2021-05]-" ]
}

@test "call two months later to commandline with explicit {}" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    run processPassedMonths --id ID --command "printf first-; printf '[%s]-' {}; printf last"
    [ $status -eq 0 ]
    [ "$output" = "first-[2021-04]-[2021-05]-last" ]
}

@test "call two months later to simple command with reconfigured [X] marker, leaving any {} intact" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    export PROCESSPASTMONTHS_MARKER='[X]'
    run processPassedMonths --id ID -- printf '[%s]-{}-' first '[X]' last
    [ $status -eq 0 ]
    [ "$output" = "[first]-{}-[2021-04]-{}-[2021-05]-{}-[last]-{}-" ]
}

@test "call two months later to combined command-line and simple command with reconfigured [X] marker, leaving any {} intact" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    export PROCESSPASTMONTHS_MARKER='@@'
    run processPassedMonths --id ID --command 'printf AA{}ZZ@@' -- printf '[%s]-{}-' first '@@' last
    [ $status -eq 0 ]
    [ "$output" = "AA{}ZZ2021-04[first]-{}-[2021-04]-{}-[2021-05]-{}-[last]-{}-" ]
}

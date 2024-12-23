#!/usr/bin/env bats

load fixture

@test "call two months later to simple command with explicit {}" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    run -0 processPassedMonths --id ID -- printf '[%s]-' first '{}' last
    assert_output "[first]-[2021-04]-[2021-05]-[last]-"
}

@test "call two months later to commandline" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    run -0 processPassedMonths --id ID --command "printf '[%s]-'"
    assert_output "[2021-04]-[2021-05]-"
}

@test "call two months later to commandline with explicit {}" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    run -0 processPassedMonths --id ID --command "printf first-; printf '[%s]-' {}; printf last"
    assert_output "first-[2021-04]-[2021-05]-last"
}

@test "call two months later to simple command with reconfigured [X] marker, leaving any {} intact" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    export PROCESSPASSEDMONTHS_MARKER='[X]'
    run -0 processPassedMonths --id ID -- printf '[%s]-{}-' first '[X]' last
    assert_output "[first]-{}-[2021-04]-{}-[2021-05]-{}-[last]-{}-"
}

@test "call two months later to combined command-line and simple command with reconfigured [X] marker, leaving any {} intact" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    export PROCESSPASSEDMONTHS_MARKER='@@'
    run -0 processPassedMonths --id ID --command 'printf AA{}ZZ@@' -- printf '[%s]-{}-' first '@@' last
    assert_output "AA{}ZZ2021-04[first]-{}-[2021-04]-{}-[2021-05]-{}-[last]-{}-"
}

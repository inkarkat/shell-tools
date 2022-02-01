#!/usr/bin/env bats

load fixture

@test "initial call exits with 99" {
    run processPassedMonths --id ID -- printf '[%s]-'

    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "call on the same month exits with 99" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-04-30
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "call on the following month passes the last month to simple command" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-05-11
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-04]-" ]
}

@test "second call on the following month exits with 99" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-05-11
    run processPassedMonths --id ID -- printf '[%s]-'

    setDate 2021-05-12
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 99 ]
    [ "$output" = "" ]
}

@test "call two months later passes the previous two months to simple command" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-04]-[2021-05]-" ]
}

@test "another call three months later passes the previous three months to simple command" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-06-01
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-04]-[2021-05]-" ]

    setDate 2021-09-01
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-06]-[2021-07]-[2021-08]-" ]
}

@test "call seven months later passes the previous seven months to simple command" {
    setDate 2021-04-20
    run processPassedMonths --id ID -- false

    setDate 2021-11-30
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-04]-[2021-05]-[2021-06]-[2021-07]-[2021-08]-[2021-09]-[2021-10]-" ]
}

@test "call on January passes the previous December to simple command" {
    setDate 2021-12-31
    run processPassedMonths --id ID -- false

    setDate 2022-01-01
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-12]-" ]
}

@test "call six months later across a year change passes the previous five months to simple command" {
    setDate 2021-09-20
    run processPassedMonths --id ID -- false

    setDate 2022-03-11
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2021-09]-[2021-10]-[2021-11]-[2021-12]-[2022-01]-[2022-02]-" ]
}

@test "call 20 months later across two years change passes the previous 20 months to simple command" {
    setDate 2019-11-20
    run processPassedMonths --id ID -- false

    setDate 2021-07-11
    run processPassedMonths --id ID -- printf '[%s]-'
    [ $status -eq 0 ]
    [ "$output" = "[2019-11]-[2019-12]-[2020-01]-[2020-02]-[2020-03]-[2020-04]-[2020-05]-[2020-06]-[2020-07]-[2020-08]-[2020-09]-[2020-10]-[2020-11]-[2020-12]-[2021-01]-[2021-02]-[2021-03]-[2021-04]-[2021-05]-[2021-06]-" ]
}

#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

export XDG_DATA_HOME="${BATS_TMPDIR}"

setDate()
{
    export DATE="date --date=${1:?}"
}

database()
{
    miniDB --table processPassedMonths "$@"
}

assert_last_month() {
    [ "$(database --query ID --columns \*)" = "$1"$'\t'"$2" ]
}
dump_last_month() {
    database --query ID --columns \* | prefix '#' >&3
}

setup() {
    database --drop || :
}

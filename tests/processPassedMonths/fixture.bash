#!/bin/bash

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

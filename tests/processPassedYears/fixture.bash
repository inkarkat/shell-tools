#!/bin/bash

export XDG_DATA_HOME="${BATS_TMPDIR}"

setDate()
{
    export DATE="date --date=${1:?}"
}

database()
{
    miniDB --table processPassedYears "$@"
}

assert_last_year() {
    [ "$(database --query ID --columns \*)" = "$1" ]
}
dump_last_year() {
    database --query ID --columns \* | prefix '#' >&3
}

setup() {
    database --drop || :
}

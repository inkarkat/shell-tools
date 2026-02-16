#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

export LOGFILE="${BATS_TEST_TMPDIR}/log"
export NOW=2026-02-16T11:11:11+00:00
export TZ=Etc/UTC

fixtureSetup()
{
    echo 'existing' > "$LOGFILE"
}
setup()
{
    fixtureSetup
}
sourceCommand()
{
    echo "stdout${*:+ }$*"
    echo >&2 "stderr${*:+ }$*"
}

export -f sourceCommand

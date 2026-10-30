#!/usr/bin/env bats

load fixture

@test "-h prints long usage help" {
    run -0 grepAllSplits -h
    refute_line -n 0 -e '^Usage:'
}

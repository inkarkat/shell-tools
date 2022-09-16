#!/usr/bin/env bats

@test "no arguments prints message and usage instructions" {
    run withAliasedCommand
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: No aliases defined.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "invalid option prints message and usage instructions" {
    run withAliasedCommand --invalid-option
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Unknown option "--invalid-option"!' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "-h prints long usage help" {
  run withAliasedCommand -h
    [ $status -eq 0 ]
    [ "${lines[0]%% *}" != 'Usage:' ]
}

@test "missing --name before --alias-command prints message and usage instructions" {
    run withAliasedCommand --alias-command dummy
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Missing -n|--name NAME before --alias-command.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "missing --name before --alias-command after NAME=ALIAS prints message and usage instructions" {
    run withAliasedCommand first=dummy --alias-command dummy
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Missing -n|--name NAME before --alias-command.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "missing --name before --alias prints message and usage instructions" {
    run withAliasedCommand --alias dummy \;
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: Missing -n|--name NAME before --alias.' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "missing --alias conclusion with ; prints message and usage instructions" {
    run withAliasedCommand --name foo --alias dummy
    [ $status -eq 2 ]
    [ "${lines[0]}" = 'ERROR: --alias command must be concluded with ;!' ]
    [ "${lines[2]%% *}" = 'Usage:' ]
}

@test "duplicate alias definition via the same way prints message and usage instructions" {
    run withAliasedCommand foo=dummy bar=lala foo=again
    [ $status -eq 2 ]
    [ "$output" = "ERROR: Duplicate alias 'foo'." ]
}

@test "duplicate alias definition via different ways prints message and usage instructions" {
    run withAliasedCommand --name foo --alias first dummy \; --name foo --alias-command again
    [ $status -eq 2 ]
    [ "$output" = "ERROR: Duplicate alias 'foo'." ]
}

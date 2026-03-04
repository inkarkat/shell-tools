#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

commandAlpha() {
    printf alpha
    [ $# -eq 0 ] || printf -- '-%s' "$@"
    printf '\n'
}

commandBeta() {
    printf beta
    [ $# -eq 0 ] || printf -- '-%s' "$@"
    printf '\n'
    return 42
}

wrapper() {
    local output="$("$@")"
    printf '[%s]\n' "$output"
}

export -f commandAlpha commandBeta wrapper

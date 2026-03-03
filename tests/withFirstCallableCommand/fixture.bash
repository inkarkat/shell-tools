#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

commandAlpha() {
    printf '%q ' alpha "$@"
}

commandBeta() {
    printf '%q ' Beta "$@"
    return 42
}

export -f commandAlpha commandBeta

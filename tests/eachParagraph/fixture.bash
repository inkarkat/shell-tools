#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert

SECTION_PREFIXER_COMMAND=(sed -e '1{ x; s#^#{}#; s#^.*/section-##; x; }' -e 'G; s#\(.*\)\n\(.*\)#\2: \1#' {})

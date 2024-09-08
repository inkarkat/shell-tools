#!/bin/bash

SECTION_PREFIXER_COMMAND=(sed -e '1{ x; s#^#{}#; s#^.*/section-##; x; }' -e 'G; s#\(.*\)\n\(.*\)#\2: \1#' {})

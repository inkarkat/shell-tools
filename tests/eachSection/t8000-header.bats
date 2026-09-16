#!/usr/bin/env bats

load fixture

@test "split headered sections with custom section info extractor for headers" {
    run -0 eachDashedHeader --file "${BATS_TEST_DIRNAME}/inputs/headered.txt" --with-header -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
opener:	01: Is a simple one.
secondary one:
02: Is the next one
02: 
02: and has more text.

third:
03: Aller
03: guten
03: Dinge
03: sind
03: drei.
03: 

final:	04: Last but not least.
EOF
}

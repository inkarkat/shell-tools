#!/usr/bin/env bats

load fixture

readonly FILENAME_AND_SIZE_LISTER="stat --format '%n %s' {} | sed -e 's#.*/##'"

@test "split (normal) headered sections" {
    run -0 eachHeader --file "${BATS_TEST_DIRNAME}/inputs/headered.txt" --with-header -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
opener:	0001: Is a simple one.
secondary one:
0002: Is the next one
0002: 
0002: and has more text.

third:
0003: Aller
0003: guten
0003: Dinge
0003: sind
0003: drei.
0003: 

final:	0004: Last but not least.
EOF
}

@test "split (normal) headered sections does not create empty files" {
    run -0 eachHeader --file "${BATS_TEST_DIRNAME}/inputs/headered.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
section-0001 17
section-0002 36
section-0003 30
section-0004 20
EOF
}

@test "split dash-dash headered sections" {
    run -0 eachDashedHeader --file "${BATS_TEST_DIRNAME}/inputs/dashdash-headered.txt" --with-header -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
opener:	0001: Is a simple one.
secondary one:
0002: Is the next one
0002: 
0002: and has more text.

third:
0003: Aller
0003: guten
0003: Dinge
0003: sind
0003: drei.
0003: 

final:	0004: Last but not least.
EOF
}

@test "split dash-dash headered sections does not create empty files" {
    run -0 eachDashedHeader --file "${BATS_TEST_DIRNAME}/inputs/dashdash-headered.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
section-0001 17
section-0002 36
section-0003 30
section-0004 20
EOF
}

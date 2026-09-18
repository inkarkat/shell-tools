#!/usr/bin/env bats

load fixture

readonly FILENAME_AND_SIZE_LISTER="stat --format '%n %s' {} | sed -e 's#.*/##'"

@test "split (normal) headered sections" {
    run -0 eachHeader --file "${BATS_TEST_DIRNAME}/inputs/headered.txt" --with-header -- "${SECTION_PREFIXER_COMMAND[@]}"
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

@test "split (normal) headered sections does not create empty files" {
    run -0 eachHeader --file "${BATS_TEST_DIRNAME}/inputs/headered.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
section-01 17
section-02 36
section-03 30
section-04 20
EOF
}

@test "split dash-dash headered sections" {
    run -0 eachDashedHeader --file "${BATS_TEST_DIRNAME}/inputs/dashdash-headered.txt" --with-header -- "${SECTION_PREFIXER_COMMAND[@]}"
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

@test "split dash-dash headered sections does not create empty files" {
    run -0 eachDashedHeader --file "${BATS_TEST_DIRNAME}/inputs/dashdash-headered.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
section-01 17
section-02 36
section-03 30
section-04 20
EOF
}

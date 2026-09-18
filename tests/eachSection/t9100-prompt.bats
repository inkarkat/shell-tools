#!/usr/bin/env bats

load fixture

readonly FILENAME_AND_SIZE_LISTER="stat --format '%n %s' {} | sed -e 's#.*/##'"

@test "split prompts" {
    run -0 eachPrompt --file "${BATS_TEST_DIRNAME}/inputs/footered.txt" --with-header -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
17401:	0000: Is a simple one.
17402:
0001: Is the next one
0001: 
0001: and has more text.

17403:
0002: Aller
0002: guten
0002: Dinge
0002: sind
0002: drei.

17404:	0003: Last but not least.
EOF
}

@test "split prompts does not create empty files" {
    run -0 eachPrompt --file "${BATS_TEST_DIRNAME}/inputs/footered.txt" --with-header --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
17401:	section-0000 17
17402:	section-0001 36
17403:	section-0002 29
17404:	section-0003 20
EOF
}

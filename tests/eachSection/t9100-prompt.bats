#!/usr/bin/env bats

load fixture

@test "split prompts" {
    run -0 eachPrompt --file "${BATS_TEST_DIRNAME}/inputs/footered.txt" --with-header -- "${SECTION_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
17401:	00: Is a simple one.
17402:
01: Is the next one
01: 
01: and has more text.

17403:
02: Aller
02: guten
02: Dinge
02: sind
02: drei.

17404:	03: Last but not least.
EOF
}

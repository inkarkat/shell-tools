#!/usr/bin/env bats

load fixture

@test "split two-liners piece filespecs are grepped" {
    run -0 grepAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --line-number -e '^T'
    assert_output - <<'EOF'
piece-aa:1:The opener
piece-ac:1:Third
EOF
}

@test "csplit dashdash-delimited filespecs are grepped" {
    run -0 grepAllCsplits --silent --suppress-matched '/^--$/' '{*}' --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" -- --line-number -e '^T'
    assert_output - <<'EOF'
piece-00:1:The opener
piece-02:1:Third
EOF
}

@test "split dashdash-delimited filespecs are grepped" {
    run -0 grepAllSections --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --line-number -e '^T'
    assert_output - <<'EOF'
section-0000:1:The opener
section-0002:1:Third
EOF
}

@test "split paragraph filespecs are grepped" {
    run -0 grepAllParagraphs --file "${BATS_TEST_DIRNAME}/inputs/paragraphs.txt" --line-number -e '^T'
    assert_output - <<'EOF'
section-0000:1:The opener
section-0002:1:Third
EOF
}

@test "split headered filespecs are grepped" {
    run -0 grepAllHeaders --file "${BATS_TEST_DIRNAME}/inputs/headered.txt" --line-number -e '^I' -e 'Dinge'
    assert_output - <<'EOF'
opener:1:Is a simple one.
secondary one:1:Is the next one
third:3:Dinge
EOF
}

@test "split dashed-headered filespecs are grepped" {
    run -0 grepAllDashedHeaders --file "${BATS_TEST_DIRNAME}/inputs/dashdash-headered.txt" --line-number -e '^I' -e 'Dinge'
    assert_output - <<'EOF'
opener:1:Is a simple one.
secondary one:1:Is the next one
third:3:Dinge
EOF
}

@test "split prompt filespecs are grepped" {
    run -0 grepAllPrompts --file "${BATS_TEST_DIRNAME}/inputs/prompts.txt" --line-number -e '^I' -e 'Dinge'
    assert_output - <<'EOF'
!17401:1:Is a simple one.
!17402:1:Is the next one
motd:4:Dinge
EOF
}

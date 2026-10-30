#!/usr/bin/env bats

load fixture

@test "split two-liners piece filespecs are appended to command" {
    COMMANDONALLSPLITS_COMMAND='wc -l' run -0 commandOnAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt"
    assert_output - <<'EOF'
  2 piece-aa
  2 piece-ab
  2 piece-ac
  2 piece-ad
  8 total
EOF
}

@test "csplit dashdash-delimited filespecs are appended to command" {
    COMMANDONALLSPLITS_COMMAND='wc -l' run -0 commandOnAllCsplits --silent --suppress-matched '/^--$/' '{*}' --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt"
    assert_output - <<'EOF'
  2 piece-00
  3 piece-01
  6 piece-02
  1 piece-03
 12 total
EOF
}

@test "csplit dashdash-delimited filespecs and passed COMMAND-ARGS after -- are appended to command" {
    # Note: Need the -- here to separate CSPLIT-OPTIONS from COMMAND-ARGS.
    COMMANDONALLSPLITS_COMMAND=wc run -0 commandOnAllCsplits --silent --suppress-matched '/^--$/' '{*}' --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" -- -l
    assert_output - <<'EOF'
  2 piece-00
  3 piece-01
  6 piece-02
  1 piece-03
 12 total
EOF
}

@test "split dashdash-delimited filespecs are appended to command" {
    COMMANDONALLSPLITS_COMMAND='wc -l' run -0 commandOnAllSections --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt"
    assert_output - <<'EOF'
  2 section-0000
  3 section-0001
  6 section-0002
  1 section-0003
 12 total
EOF
}

@test "split paragraph filespecs are appended to command" {
    COMMANDONALLSPLITS_COMMAND='wc -l' run -0 commandOnAllParagraphs --file "${BATS_TEST_DIRNAME}/inputs/paragraphs.txt"
    assert_output - <<'EOF'
  2 section-0000
  3 section-0001
  6 section-0002
  1 section-0003
 12 total
EOF
}

@test "split headered filespecs are appended to command" {
    COMMANDONALLSPLITS_COMMAND='wc -l' run -0 commandOnAllHeaders --file "${BATS_TEST_DIRNAME}/inputs/headered.txt"
    assert_output - <<'EOF'
  1 opener
  3 secondary one
  6 third
  1 final
 11 total
EOF
}

@test "split dashed-headered filespecs are appended to command" {
    COMMANDONALLSPLITS_COMMAND='wc -l' run -0 commandOnAllDashedHeaders --file "${BATS_TEST_DIRNAME}/inputs/dashdash-headered.txt"
    assert_output - <<'EOF'
  1 opener
  3 secondary one
  6 third
  1 final
 11 total
EOF
}

@test "split prompt filespecs are appended to command" {
    COMMANDONALLSPLITS_COMMAND='wc -l' run -0 commandOnAllPrompts --file "${BATS_TEST_DIRNAME}/inputs/prompts.txt"
    assert_output - <<'EOF'
  1 !17401
  3 !17402
  6 motd
  2 cat /etc/motd
 12 total
EOF
}

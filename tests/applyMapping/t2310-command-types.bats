#!/usr/bin/env bats

load fixture

@test "process SIMPLECOMMAND" {
    run -0 applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" -- echo 'A dog and a fox.'
    assert_output 'A cat and a wolf.'
}

@test "process COMMANDLINE" {
    run -0 applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" --command "echo 'A dog and a fox.'"
    assert_output 'A cat and a wolf.'
}

@test "process --exec COMMAND ;" {
    run -0 applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" --exec echo 'A dog and a fox.' \;
    assert_output 'A cat and a wolf.'
}

@test "process all types together" {
    run -0 applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" --command "echo 'My dog has fleas.'" --exec echo 'A dog and a fox.' \; echo 'Is that a fox?'
    assert_output - <<'EOF'
My cat has fleas.
A cat and a wolf.
Is that a wolf?
EOF
}

@test "failing COMMAND's exit status is returned" {
    run -42 applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" --exec echo 'A dog and a fox.' \; --command '(exit 42)'
    assert_output 'A cat and a wolf.'
}

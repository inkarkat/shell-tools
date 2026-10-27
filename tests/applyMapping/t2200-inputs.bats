#!/usr/bin/env bats

load fixture

setup()
{
    readonly MAPPING_FILE="${BATS_FILE_TMPDIR}/mapping.txt"
    cat > "$MAPPING_FILE" <<'EOF'
dog	cat
the	a
The	Da
EOF
}

assert_mapped_output()
{
    assert_output - <<'EOF'
Da \quick\ `brown` fox \\
jumps over a **lazy** cat.
Foxes and cats are ... animals.
My cat is a good/bad cat.
And [fox] and "cat" A+
EOF
}

@test "mapping file and input from stdin" {
    run -0 applyMapping "$MAPPING_FILE" - < "${BATS_TEST_DIRNAME}/input.txt"
    assert_mapped_output
}

@test "mapping file and input file" {
    run -0 applyMapping "$MAPPING_FILE" "${BATS_TEST_DIRNAME}/input.txt"
    assert_mapped_output
}

@test "mapping file and two input files" {
    run -0 applyMapping "$MAPPING_FILE" <(head -n 2 -- "${BATS_TEST_DIRNAME}/input.txt") <(tail -n +3 -- "${BATS_TEST_DIRNAME}/input.txt")
    assert_mapped_output
}

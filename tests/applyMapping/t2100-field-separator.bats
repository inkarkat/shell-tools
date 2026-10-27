#!/usr/bin/env bats

load fixture

readonly TAB_MAPPING="$(cat <<'EOF'
dog	cat
 and 	&
/	 <> 
EOF
)"

@test "apply mapping with default whitespace field separator" {
    run -0 applyMapping - "${BATS_TEST_DIRNAME}/input.txt" <<<"$TAB_MAPPING"
    assert_output - <<'EOF'
The \quick\ `brown` fox \\
jumps over the **lazy** cat.
Foxes & cats are ... animals.
My cat is a good<>bad cat.
And [fox] & "cat" A+
EOF
}

@test "apply mapping with tab field separator" {
    run -0 applyMapping -F $'\t' - "${BATS_TEST_DIRNAME}/input.txt" <<<"$TAB_MAPPING"
    assert_output - <<'EOF'
The \quick\ `brown` fox \\
jumps over the **lazy** cat.
Foxes&cats are ... animals.
My cat is a good <> bad cat.
And [fox]&"cat" A+
EOF
}

@test "apply mapping with dash field separator" {
    run -0 applyMapping -F - - "${BATS_TEST_DIRNAME}/input.txt" <<'EOF'
dog-cat
 and -&
/- <> 
EOF
    assert_output - <<'EOF'
The \quick\ `brown` fox \\
jumps over the **lazy** cat.
Foxes&cats are ... animals.
My cat is a good <> bad cat.
And [fox]&"cat" A+
EOF
}

@test "mapping lines without a separator are ignored" {
    run -0 applyMapping -F $'\t' - "${BATS_TEST_DIRNAME}/input.txt" <<'EOF'
dog	cat
fox
the	a
The	Da
Foxes
EOF
    assert_output - <<'EOF'
Da \quick\ `brown` fox \\
jumps over a **lazy** cat.
Foxes and cats are ... animals.
My cat is a good/bad cat.
And [fox] and "cat" A+
EOF
}

@test "mapping to empty string" {
    run -0 applyMapping -F $'\t' - "${BATS_TEST_DIRNAME}/input.txt" <<'EOF'
dog	cat
fox	
the	a
The	Da
ox	
EOF
    assert_output - <<'EOF'
Da \quick\ `brown`  \\
jumps over a **lazy** cat.
Fes and cats are ... animals.
My cat is a good/bad cat.
And [] and "cat" A+
EOF
}

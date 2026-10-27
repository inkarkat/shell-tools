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

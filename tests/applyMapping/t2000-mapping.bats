#!/usr/bin/env bats

load fixture

@test "apply single mapping" {
    run -0 applyMapping --mapping-file - --file "${BATS_TEST_DIRNAME}/input.txt" <<<$'dog\tcat'
    assert_output - <<'EOF'
The \quick\ `brown` fox \\
jumps over the **lazy** cat.
Foxes and cats are ... animals.
My cat is a good/bad cat.
And [fox] and "cat" A+
EOF
}

@test "apply multiple mappings from top to bottom" {
    run -0 applyMapping --mapping-file - --file "${BATS_TEST_DIRNAME}/input.txt" <<'EOF'
dog	cat
the	a
The	Da
ox	OX
fox	YYY
fOX	XXX
EOF
    assert_output - <<'EOF'
Da \quick\ `brown` XXX \\
jumps over a **lazy** cat.
FOXes and cats are ... animals.
My cat is a good/bad cat.
And [XXX] and "cat" A+
EOF
}

@test "apply mappings with special regexp characters" {
    run -0 applyMapping --mapping-file - --file "${BATS_TEST_DIRNAME}/input.txt" <<'EOF'
dog	cat
the	a
The	Da
[fox]	X&Y
ox	OX
fOX	XXX
\	#
/	\&\
`	'
**	_
.	\
A+	B-
EOF
    assert_output - <<'EOF'
Da #quick# 'brown' XXX ##
jumps over a _lazy_ cat\
FOXes and cats are \\\ animals\
My cat is a good\&\bad cat\
And X&Y and "cat" B-
EOF
}

@test "prints warning with duplicate keys and uses the first" {
    run -0 --separate-stderr applyMapping --mapping-file - --file "${BATS_TEST_DIRNAME}/input.txt" <<'EOF'
dog	cat
dog	mouse
fox	FOX
Fox	XXX
the	a
The	Da
fox	???
EOF
    assert_output - <<'EOF'
Da \quick\ `brown` FOX \\
jumps over a **lazy** cat.
XXXes and cats are ... animals.
My cat is a good/bad cat.
And [FOX] and "cat" A+
EOF
    output="$stderr" assert_output - <<'EOF'
Warning: Duplicate key: dog
Warning: Duplicate key: fox
EOF
}

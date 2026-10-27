#!/usr/bin/env bats

load fixture

mixedOutput()
{
    echo 'The quick brown fox'
    echo 'jumps over the lazy dog.'
    echo 'Look at the carpet! Bad dog!' >&2
    echo 'I like foxes and dogs.'
    echo 'Beware of the fox!' >&2
}
export -f mixedOutput

@test "process command stdout and stderr by default" {
    run -0 --separate-stderr applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" -- mixedOutput
    assert_output - <<'EOF'
The quick brown wolf
jumps over the lazy cat.
I like wolfes and cats.
EOF
    output="$stderr" assert_output - <<'EOF'
Look at the carpet! Bad cat!
Beware of the wolf!
EOF
}

@test "process command stdout and stderr explicitly" {
    run -0 --separate-stderr applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" --stdout --stderr -- mixedOutput
    assert_output - <<'EOF'
The quick brown wolf
jumps over the lazy cat.
I like wolfes and cats.
EOF
    output="$stderr" assert_output - <<'EOF'
Look at the carpet! Bad cat!
Beware of the wolf!
EOF
}

@test "process command only stdout" {
    run -0 --separate-stderr applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" --stdout -- mixedOutput
    assert_output - <<'EOF'
The quick brown wolf
jumps over the lazy cat.
I like wolfes and cats.
EOF
    output="$stderr" assert_output - <<'EOF'
Look at the carpet! Bad dog!
Beware of the fox!
EOF
}

@test "process command only stderr" {
    run -0 --separate-stderr applyMapping --mapping-file "${BATS_TEST_DIRNAME}/mapping.tsv" --stderr -- mixedOutput
    assert_output - <<'EOF'
The quick brown fox
jumps over the lazy dog.
I like foxes and dogs.
EOF
    output="$stderr" assert_output - <<'EOF'
Look at the carpet! Bad cat!
Beware of the wolf!
EOF
}

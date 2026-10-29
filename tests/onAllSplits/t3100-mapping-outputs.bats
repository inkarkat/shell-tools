#!/usr/bin/env bats

load fixture

@test "split two-liners piece default mapping of filespecs to filenames both stdout and stderr by default" {
    run -0 --separate-stderr onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --exec printf 'working on %s\n' '{G}' \; --command 'printf >&2 "failing on %s\\n" {}'
    assert_output - <<'EOF'
working on piece-aa
working on piece-ab
working on piece-ac
working on piece-ad
EOF
    output="$stderr" assert_output - <<'EOF'
failing on piece-aa
failing on piece-ab
failing on piece-ac
failing on piece-ad
EOF
}

@test "split two-liners piece default mapping of filespecs to filenames only stdout" {
    run -0 --separate-stderr onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --stdout --exec printf 'working on %s\n' '{G}' \; --command 'printf >&2 "failing on %s\\n" {}'
    assert_output - <<'EOF'
working on piece-aa
working on piece-ab
working on piece-ac
working on piece-ad
EOF
    output="$stderr" refute_output - <<'EOF'
failing on piece-aa
failing on piece-ab
failing on piece-ac
failing on piece-ad
EOF
}

@test "split two-liners piece default mapping of filespecs to filenames only stderr" {
    run -0 --separate-stderr onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --stderr --exec printf 'working on %s\n' '{G}' \; --command 'printf >&2 "failing on %s\\n" {}'
    refute_output - <<'EOF'
working on piece-aa
working on piece-ab
working on piece-ac
working on piece-ad
EOF
    output="$stderr" assert_output - <<'EOF'
failing on piece-aa
failing on piece-ab
failing on piece-ac
failing on piece-ad
EOF
}

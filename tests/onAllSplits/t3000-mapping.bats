#!/usr/bin/env bats

load fixture

@test "split two-liners piece default mapping of filespecs to filenames" {
    run -0 onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --exec printf 'working on %s\n' \;
    assert_output - <<'EOF'
working on piece-aa
working on piece-ab
working on piece-ac
working on piece-ad
EOF
}

@test "split two-liners piece mapping of filespecs to extracted info" {
    run -0 onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --piece-info-extractor-exec head -n 1 -- \; --exec printf '%s piece\n' \;
    assert_output - <<'EOF'
The opener piece
Secondary piece
Third piece
Last piece
EOF
}

@test "split two-liners run multiple commands" {
    run -0 onAllSplits --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --exec wc -l -- '{G}' \; -- grep -Hn '^Is ' -- '{G}'
    assert_output - <<'EOF'
  2 piece-aa
  2 piece-ab
  2 piece-ac
  2 piece-ad
  8 total
piece-aa:2:Is a simple one.
piece-ab:2:Is the next one.
EOF
}

#!/usr/bin/env bats

load fixture

readonly FILENAME_AND_SIZE_LISTER="stat --format '%n %s' {} | sed -e 's#.*/##'"

@test "splitting empty input does not invoke the command and exits with 99" {
    run -99 eachCsplit --quiet --elide-empty-files --suppress-matched '/^--$/' '{*}' --file /dev/null -- echo WHAT
    assert_output ''
}

@test "splitting empty input with prompt does not invoke the command and exits with 99" {
    run -99 eachCsplit --with-prompt --quiet --elide-empty-files --suppress-matched '/^--$/' '{*}' --file /dev/null -- echo WHAT
    assert_output ''
}

@test "splitting empty pieces gives empty files" {
    run -0 eachCsplit --quiet --suppress-matched '/^--$/' '{*}' --file "${BATS_TEST_DIRNAME}/inputs/dashdash-with-empty.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
piece-00 0
piece-01 26
piece-02 0
piece-03 19
piece-04 20
piece-05 0
EOF
}

@test "splitting empty pieces with --elide-empty-files does not create empty files" {
    run -0 eachCsplit --quiet --suppress-matched '/^--$/' '{*}' --elide-empty-files --file "${BATS_TEST_DIRNAME}/inputs/dashdash-with-empty.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
piece-00 26
piece-01 19
piece-02 20
EOF
}

@test "splitting regular pieces with --elide-empty-files has no effect" {
    run -0 eachCsplit --quiet --suppress-matched '/^--$/' '{*}' --elide-empty-files --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
piece-00 28
piece-01 45
piece-02 35
piece-03 20
EOF
}

@test "splitting empty pieces with --elide-empty-first omits empty first file" {
    run -0 eachCsplit --quiet --suppress-matched '/^--$/' '{*}' --elide-empty-first --file "${BATS_TEST_DIRNAME}/inputs/dashdash-with-empty.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
piece-01 26
piece-02 0
piece-03 19
piece-04 20
piece-05 0
EOF
}

@test "splitting regular pieces with --elide-empty-first has no effect" {
    run -0 eachCsplit --quiet --suppress-matched '/^--$/' '{*}' --elide-empty-first --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
piece-00 28
piece-01 45
piece-02 35
piece-03 20
EOF
}

@test "splitting empty pieces with --elide-empty-last omits empty last file" {
    run -0 eachCsplit --quiet --suppress-matched '/^--$/' '{*}' --elide-empty-last --file "${BATS_TEST_DIRNAME}/inputs/dashdash-with-empty.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
piece-00 0
piece-01 26
piece-02 0
piece-03 19
piece-04 20
EOF
}

@test "splitting regular pieces with --elide-empty-last has no effect" {
    run -0 eachCsplit --quiet --suppress-matched '/^--$/' '{*}' --elide-empty-last --file "${BATS_TEST_DIRNAME}/inputs/dashdash-delimited.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
piece-00 28
piece-01 45
piece-02 35
piece-03 20
EOF
}

@test "splitting empty pieces with --elide-empty-first and --elide-empty-last omits empty first and last files" {
    run -0 eachCsplit --quiet --suppress-matched '/^--$/' '{*}' --elide-empty-first --elide-empty-last --file "${BATS_TEST_DIRNAME}/inputs/dashdash-with-empty.txt" --command "$FILENAME_AND_SIZE_LISTER"
    assert_output - <<'EOF'
piece-01 26
piece-02 0
piece-03 19
piece-04 20
EOF
}

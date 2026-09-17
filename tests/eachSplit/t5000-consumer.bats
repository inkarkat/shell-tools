#!/usr/bin/env bats

load fixture

@test "split two-liners piece filespecs are appended to consumer command, header and prompt flags are ignored" {
    for flag in '' --with-header --with-prompt
    do
	run -0 eachSplit --lines=2 $flag --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --consumer-exec grep -nh -e '^' -- \; \
	    && {
		assert_output - <<'EOF'
1:The opener
2:Is a simple one.
1:Secondary
2:Is the next one.
1:Third
2:Aller guten Dinge sind drei.
1:Last
2:but not least.
EOF
	    } || fail "$flag"
    done
}

@test "split two-liners piece filespecs are inserted at {} marker" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --consumer-exec xargs --arg-file {} -d '\n' -n 1 grep -nh -e '^' -- \;
    assert_output - <<'EOF'
1:The opener
2:Is a simple one.
1:Secondary
2:Is the next one.
1:Third
2:Aller guten Dinge sind drei.
1:Last
2:but not least.
EOF
}

@test "split two-liners piece info mapping file mapping filespecs to filenames is inserted at {M} marker" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --consumer-exec cat -- {M} \;
    assert_line -n 0 -e '/piece-aa	piece-aa$'
    assert_line -n 1 -e '/piece-ab	piece-ab$'
    assert_line -n 2 -e '/piece-ac	piece-ac$'
    assert_line -n 3 -e '/piece-ad	piece-ad$'
    assert_line -n 4 ''
}

@test "split two-liners piece info mapping file mapping filespecs to extracted info is inserted at {M} marker" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --piece-info-extractor-exec head -n 1 -- \; --consumer-exec cat -- '{M}' \;
    assert_line -n 0 -e '/piece-aa	The opener$'
    assert_line -n 1 -e '/piece-ab	Secondary$'
    assert_line -n 2 -e '/piece-ac	Third$'
    assert_line -n 3 -e '/piece-ad	Last$'
    assert_line -n 4 ''
}

@test "split two-liners, prefix each piece is done first, then consumer command is run" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --consumer-exec grep -nh -e '^' -- \; -- "${PIECE_PREFIXER_COMMAND[@]}"
    assert_output - <<'EOF'
aa: The opener
aa: Is a simple one.
ab: Secondary
ab: Is the next one.
ac: Third
ac: Aller guten Dinge sind drei.
ad: Last
ad: but not least.
1:The opener
2:Is a simple one.
1:Secondary
2:Is the next one.
1:Third
2:Aller guten Dinge sind drei.
1:Last
2:but not least.
EOF
}

@test "split two-liners, remove some pieces, then consumer command is run with all pieces' filespecs" {
    run -2 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --consumer-command 'grep -nh -e ^ --' --command 'grep -q -e "^T" {} || rm -- {}'
    assert_line -n 0 '1:The opener'
    assert_line -n 1 '2:Is a simple one.'
    assert_line -n 2 -e '^grep: .*/piece-ab: No such file or directory$'
    assert_line -n 3 '1:Third'
    assert_line -n 4 '2:Aller guten Dinge sind drei.'
    assert_line -n 5 -e '^grep: .*/piece-ad: No such file or directory$'
}

@test "split two-liners, remove some pieces, then consumer command is run on a glob of the remaining pieces" {
    run -0 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --consumer-exec grep -nh -e '^' -- '{G}' \;  --command 'grep -q -e "^T" {} || rm -- {}'
    assert_output - <<'EOF'
1:The opener
2:Is a simple one.
1:Third
2:Aller guten Dinge sind drei.
EOF
}

@test "split two-liners, when the command on some pieces fails, the consumer command is not run at all" {
    run -1 eachSplit --lines=2 --file "${BATS_TEST_DIRNAME}/inputs/two-liners.txt" --consumer-exec echo 'I got these pieces:' '{G}' \;  --command 'grep -q -e "^T" {} && echo "Keeping $(basename {})"'
    assert_output - <<'EOF'
Keeping piece-aa
Keeping piece-ac
EOF
}

@test "on empty input, the consumer command is not run at all" {
    run -99 eachSplit --lines=2 --file /dev/null --consumer-exec echo 'I got these pieces:' '{G}' \;
    assert_output ''
}

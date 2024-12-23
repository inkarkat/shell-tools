#!/bin/bash

bats_require_minimum_version 1.5.0
bats_load_library bats-support
bats_load_library bats-assert
bats_load_library bats-file

setup()
{
    readonly FILE1="${BATS_TMPDIR}/FILE1"; echo "FOO" > "$FILE1"
    readonly FILE2="${BATS_TMPDIR}/FILE2"; echo "fox" > "$FILE2"
    changeAllCommand=(sed -i -e 's/[oO]\+/i/g')
    changeAndDeleteCommand=(sed -i -e 's/[oO]\+/i/g' -e '/x/d')
    failAllCommand=(sed -i -e '/[oO]/q 1')
    deleteAllCommand=(sed -i -e '/[oO]/d')
    failFirstCommand=(sed -i -e 's/o/i/g' -e '/O/q 1')
    deleteAndFailCommand=(sed -i -e '/O/d' -e '/o/q 1')
}

assertFile1Unchanged()
{

    assert_equal "$(< "${1:-$FILE1}")" 'FOO'
}
assertFile2Unchanged()
{
    assert_equal "$(< "${1:-$FILE2}")" 'fox'
}
assertFile1Changed()
{
    assert_equal "$(< "${1:-$FILE1}")" 'Fi'
}
assertFile2Changed()
{
    assert_equal "$(< "${1:-$FILE2}")" 'fix'
}
assertFile1Deleted()
{
    assert_not_exists "${1:-$FILE1}"
}
assertFile2Deleted()
{
    assert_not_exists "${1:-$FILE2}"
}

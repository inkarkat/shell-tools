#!/usr/bin/env bats

load fixture

@test "initial call queries all later files and passes to simple command" {
    LASTFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output "[foo]-[bar]-[with space]-"
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

@test "initial call and two later updates, concluded by no further updates and passes to simple command" {
    LASTFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output "[foo]-[bar]-[with space]-"
    assert_args '--count 2147483647 --'
    assert_last 'with space'

    LASTFILES='something else'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output "[something else]-"
    assert_args '--after with\ space --'
    assert_last 'something else'

    LASTFILES='last\nfiles'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output "[last]-[files]-"
    assert_args '--after something\ else --'
    assert_last 'files'

    LASTFILES=''
    run -99 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output ''
    assert_args '--after files --'
    assert_last 'files'
}

@test "initial call queries all later files and passes to simple command with explicit {}" {
    LASTFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-' first '{}' last

    assert_output "[first]-[foo]-[bar]-[with space]-[last]-"
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

@test "initial call queries later all files and passes to commandline" {
    LASTFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --after --command "printf '[%s]-'"

    assert_output "[foo]-[bar]-[with space]-"
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

@test "initial call queries all later files and passes to commandline with explicit {}" {
    LASTFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --after --command "printf first-; printf '[%s]-' {}; printf last"

    assert_output "first-[foo]-[bar]-[with space]-last"
    assert_args '--count 2147483647 --'
}

@test "a failing command gets its exit status returned and does not modify the database" {
    LASTFILES='foo\nbar\nwith space'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-'

    assert_output "[foo]-[bar]-[with space]-"
    assert_args '--count 2147483647 --'

    LASTFILES='something else'
    run -66 processAddedFiles --id ID --after --command '(printf %s {}; exit 66)'

    assert_output "something else"
    assert_args '--after with\ space --'
    assert_last 'with space'
}

@test "initial call queries all later files and passes to simple command with reconfigured [X] marker, leaving any {} intact" {
    LASTFILES='foo\nbar\nwith space'
    export PROCESSADDEDFILES_FILE_MARKER='[X]'
    run -0 processAddedFiles --id ID --after -- printf '[%s]-{}-' first '[X]' last

    assert_output "[first]-{}-[foo]-{}-[bar]-{}-[with space]-{}-[last]-{}-"
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

@test "initial call queries all later files and passes to combined command-line and simple command with reconfigured [X] marker, leaving any {} intact" {
    LASTFILES='foo\nbar\nwith space'
    export PROCESSADDEDFILES_FILE_MARKER='@@'
    run -0 processAddedFiles --id ID --after --command 'printf AA{}ZZ@@' -- printf '[%s]-{}-' first '@@' last

    assert_output "AA{}ZZfoo[first]-{}-[foo]-{}-[bar]-{}-[with space]-{}-[last]-{}-"
    assert_args '--count 2147483647 --'
    assert_last 'with space'
}

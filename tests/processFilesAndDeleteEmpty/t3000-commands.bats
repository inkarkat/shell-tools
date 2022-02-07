#!/usr/bin/env bats

readonly foo="${BATS_TMPDIR}/foo"
readonly bar="${BATS_TMPDIR}/b a r"

@test "--command, two files appended" {
    run processFilesAndDeleteEmpty --command "printf [%s]- X" "$foo" "$bar"
    [ "$output" = "[X]-[${foo}]-[${bar}]-" ]
}

@test "--command, two files via {}" {
    run processFilesAndDeleteEmpty --command "printf [%s]- {} X" "$foo" "$bar"
    [ "$output" = "[${foo}]-[${bar}]-[X]-" ]
}

@test "--exec simple ;, two files appended" {
    run processFilesAndDeleteEmpty --exec printf '[%s]-' X \; "$foo" "$bar"
    [ "$output" = "[X]-[${foo}]-[${bar}]-" ]
}

@test "--exec simple ;, two files via {}" {
    run processFilesAndDeleteEmpty --exec printf '[%s]-' {} X \; "$foo" "$bar"
    [ "$output" = "[${foo}]-[${bar}]-[X]-" ]
}

@test "--command and --exec, two files appended" {
    run processFilesAndDeleteEmpty --command "printf [%s]-" --exec printf '{%s}-' \; "$foo" "$bar"
    [ "$output" = "[]-{${foo}}-{${bar}}-" ]
}

@test "--command and --exec, two files via {}" {
    run processFilesAndDeleteEmpty --command "printf [%s]- {}" --exec printf '{%s}-' {} \; "$foo" "$bar"
    [ "$output" = "[${foo}]-[${bar}]-{${foo}}-{${bar}}-" ]
}

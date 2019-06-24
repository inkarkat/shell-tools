#!/usr/bin/env bats

@test "creating a nonexisting file in a nonexisting directory returns 5" {
    TARGET_DIR="${BATS_TMPDIR}/doesNotExist"
    [ ! -e "$TARGET_DIR" ]
    NONEXISTING="${TARGET_DIR}/doesNotExistEither"
    export MEMOIZEDECISION_CHOICE=y
    run containedOrAddOrUpdate --create-nonexisting --in-place --line "foo=new" "$NONEXISTING"
    [ $status -eq 5 ]
    [ "${#lines[@]}" -eq 1 ]
    [[ "$output" =~ /doesNotExist/doesNotExistEither:\ No\ such\ file\ or\ directory$ ]]
}

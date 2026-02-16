#!/usr/bin/env bats

load fixture

@test "print and capture both stdout and stderr" {
    run -0 withLoggingTo "$LOGFILE" --tee -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output - <<'EOF'
stdout
stderr
EOF
}

@test "print and capture only stdout" {
    run -0 withLoggingTo "$LOGFILE" --tee --stdout -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output 'stdout'
}

@test "print and capture only stderr" {
    run -0 withLoggingTo "$LOGFILE" --tee --stderr -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output 'stderr'
}

@test "print and append both stdout and stderr" {
    run -0 withLoggingTo "$LOGFILE" --tee --append -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
stdout
stderr
EOF
}

@test "print and append only stdout" {
    run -0 withLoggingTo "$LOGFILE" --tee --append --stdout -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
stdout
EOF
}

@test "print and append only stderr" {
    run -0 withLoggingTo "$LOGFILE" --tee --append --stderr -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
stderr
EOF
}

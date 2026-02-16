#!/usr/bin/env bats

load fixture

@test "capture both stdout and stderr" {
    run -0 withLoggingTo "$LOGFILE" -- sourceCommand
    output=$(<"$LOGFILE") assert_output - <<'EOF'
stdout
stderr
EOF
}

@test "capture only stdout" {
    run -0 withLoggingTo "$LOGFILE" --stdout -- sourceCommand
    assert_output 'stderr'
    output=$(<"$LOGFILE") assert_output 'stdout'
}

@test "capture only stderr" {
    run -0 withLoggingTo "$LOGFILE" --stderr -- sourceCommand
    assert_output 'stdout'
    output=$(<"$LOGFILE") assert_output 'stderr'
}

@test "append both stdout and stderr" {
    run -0 withLoggingTo "$LOGFILE" --append -- sourceCommand
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
stdout
stderr
EOF
}

@test "append only stdout" {
    run -0 withLoggingTo "$LOGFILE" --append --stdout -- sourceCommand
    assert_output 'stderr'
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
stdout
EOF
}

@test "append only stderr" {
    run -0 withLoggingTo "$LOGFILE" --append --stderr -- sourceCommand
    assert_output 'stdout'
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
stderr
EOF
}

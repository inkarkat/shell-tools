#!/usr/bin/env bats

load fixture

@test "capture with timestamp both stdout and stderr" {
    run -0 withLoggingTo "$LOGFILE" --timestamp -- sourceCommand
    output=$(<"$LOGFILE") assert_output - <<'EOF'
16-Feb-2026 11:11:11,000 stdout
16-Feb-2026 11:11:11,000 stderr
EOF
}

@test "capture with timestamp only stdout" {
    run -0 withLoggingTo "$LOGFILE" --timestamp --stdout -- sourceCommand
    assert_output 'stderr'
    output=$(<"$LOGFILE") assert_output '16-Feb-2026 11:11:11,000 stdout'
}

@test "capture with timestamp only stderr" {
    run -0 withLoggingTo "$LOGFILE" --timestamp --stderr -- sourceCommand
    assert_output 'stdout'
    output=$(<"$LOGFILE") assert_output '16-Feb-2026 11:11:11,000 stderr'
}

@test "append with timestamp both stdout and stderr" {
    run -0 withLoggingTo "$LOGFILE" --timestamp --append -- sourceCommand
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
16-Feb-2026 11:11:11,000 stdout
16-Feb-2026 11:11:11,000 stderr
EOF
}

@test "append with timestamp only stdout" {
    run -0 withLoggingTo "$LOGFILE" --timestamp --append --stdout -- sourceCommand
    assert_output 'stderr'
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
16-Feb-2026 11:11:11,000 stdout
EOF
}

@test "append with timestamp only stderr" {
    run -0 withLoggingTo "$LOGFILE" --timestamp --append --stderr -- sourceCommand
    assert_output 'stdout'
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
16-Feb-2026 11:11:11,000 stderr
EOF
}

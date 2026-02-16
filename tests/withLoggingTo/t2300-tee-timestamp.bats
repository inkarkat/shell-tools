#!/usr/bin/env bats

load fixture

@test "print and capture with timestamp both stdout and stderr" {
    run -0 withLoggingTo "$LOGFILE" --tee --timestamp -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output - <<'EOF'
16-Feb-2026 11:11:11,000 stdout
16-Feb-2026 11:11:11,000 stderr
EOF
}

@test "print and capture with timestamp only stdout" {
    run -0 withLoggingTo "$LOGFILE" --tee --timestamp --stdout -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output '16-Feb-2026 11:11:11,000 stdout'
}

@test "print and capture with timestamp only stderr" {
    run -0 withLoggingTo "$LOGFILE" --tee --timestamp --stderr -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output '16-Feb-2026 11:11:11,000 stderr'
}

@test "print and append with timestamp both stdout and stderr" {
    run -0 withLoggingTo "$LOGFILE" --tee --timestamp --append -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
16-Feb-2026 11:11:11,000 stdout
16-Feb-2026 11:11:11,000 stderr
EOF
}

@test "print and append with timestamp only stdout" {
    run -0 withLoggingTo "$LOGFILE" --tee --timestamp --append --stdout -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
16-Feb-2026 11:11:11,000 stdout
EOF
}

@test "print and append with timestamp only stderr" {
    run -0 withLoggingTo "$LOGFILE" --tee --timestamp --append --stderr -- sourceCommand
    contains 'stdout' "${lines[@]}"
    contains 'stderr' "${lines[@]}"
    output=$(<"$LOGFILE") assert_output - <<'EOF'
existing
16-Feb-2026 11:11:11,000 stderr
EOF
}

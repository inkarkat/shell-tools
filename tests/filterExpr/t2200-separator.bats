#!/usr/bin/env bats

load fixture

@test "tab separator allows args with spaces" {
    run -0 filterExpr --field-separator $'\t' --command '[ $(echo {} | wc --words) -eq 2 ]' <<< $'foo bar\tyes\none\tno\none more\tyeah\nthree words here\twhat'
    assert_output - <<'EOF'
yes
yeah
EOF
}

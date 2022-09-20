#!/bin/sh source-this-script

NO_DASHDASH=t UNTIL_DASHDASH=t addAliasSupport eachDir \
    'l' \
    'local-dir|with-header|with-prompt|trailing-prompt|no-trailing-prompt|no-output-no-prompt|no-output-no-error|emulate-prompt|no-success-no-count|exit-on-success|exit-on-failure|worst-status' \
    '' \
    'initial-status|no-count-on|exit-on|comment|summarize-failed|summarize-failed-separator|between-command|usage-redirect'
NO_DASHDASH=t UNTIL_DASHDASH=t addAliasSupport eachFile \
    'l' \
    'local-dir|with-header|with-prompt|trailing-prompt|no-trailing-prompt|no-output-no-prompt|no-output-no-error|emulate-prompt|no-success-no-count|exit-on-success|exit-on-failure|worst-status' \
    '' \
    'initial-status|no-count-on|exit-on|comment|summarize-failed|summarize-failed-separator|between-command|usage-redirect'

# Note: Aim for support of NAME=ALIAS-COMMAND (once);
# --alias ALIAS-COMMAND [...] ; cannot be parsed right now with addAliasSupport.
INITIAL_ARGUMENT_COUNT=1 addAliasSupport withAliasedCommand \
    '' \
    '' \
    'n' \
    'name|alias|alias-command'

INITIAL_ARGUMENT_COUNT=1 addAliasSupport withPath \
    'C' \
    'clean'

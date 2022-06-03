#!/bin/sh source-this-script

INITIAL_ARGUMENT_COUNT=1 addAliasSupport withPath \
    'C' \
    'clean'

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

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

addAliasSupport tempdir \
    'k' \
    'keep|keep-on-success|keep-on-failure|stdin' \
    'dCn' \
    'or-existing|create-subdir|name'

addAliasSupport tempfile \
    '' \
    '' \
    'dbe' \
    'directory|basename|extension'


# Use my own ~/tmp instead of the system default temp directory.
if [ -d ~/tmp ]; then
    alias tempedit='TMPDIR=~/tmp tempedit'
    alias tempfile='TMPDIR=~/tmp tempfile'
    alias tempfileAndEdit='TMPDIR=~/tmp tempfileAndEdit'
fi

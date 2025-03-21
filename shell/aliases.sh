#!/bin/sh source-this-script

NO_DASHDASH=t UNTIL_DASHDASH=t eval "$(runWithPrompt --addAliasSupport eachDir \
    'l' \
    'local-dir' \
    '' \
    ''
)"
NO_DASHDASH=t UNTIL_DASHDASH=t eval "$(runWithPrompt --addAliasSupport eachFile \
    'l' \
    'local-dir' \
    '' \
    ''
)"
# Note: Aim for support of NAME=ALIAS-COMMAND (once);
# --alias ALIAS-COMMAND [...] ; cannot be parsed right now with addAliasSupport.
INITIAL_ARGUMENT_COUNT=1 addAliasSupport withAliasedCommand \
    '' \
    '' \
    'n' \
    'name|alias|alias-command'

INITIAL_ARGUMENT_COUNT=1 addAliasSupport withDir \
    '' \
    'bare|trailing-prompt|no-trailing-prompt|emulate-prompt|worst-status'

INITIAL_ARGUMENT_COUNT=1 addAliasSupport withPath \
    'C' \
    'clean'

addAliasSupport tempdir \
    'k' \
    'keep|keep-on-success|keep-on-failure|stdin' \
    'dCn' \
    'or-existing|create-subdir|name'

addAliasSupport tempedit \
    'PC' \
    'no-print|cleanup|edit-empty' \
    'dbe' \
    'directory|basename|extension'

addAliasSupport tempfileAndEdit \
    'C' \
    'cleanup|edit-empty' \
    'dbe' \
    'directory|basename|extension'

addAliasSupport tempfileAndOpen \
    'C' \
    'cleanup' \
    'dbe' \
    'directory|basename|extension'

addAliasSupport tempfile \
    '' \
    '' \
    'dbesS' \
    'directory|basename|extension|sink-command|sink-exec'

addAliasSupport withDebug \
    'v' \
    'verbose' \
    'mM' \
    'module|only-module|for'


# Use my own ~/tmp instead of the system default temp directory.
if [ -d ~/tmp ]; then
    alias tempedit='TMPDIR=~/tmp tempedit'
    alias tempfile='TMPDIR=~/tmp tempfile'
    alias tempfileAndEdit='TMPDIR=~/tmp tempfileAndEdit'
    alias tempfileAndOpen='TMPDIR=~/tmp tempfileAndOpen'
fi

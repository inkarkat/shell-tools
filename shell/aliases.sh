#!/bin/sh source-this-script

NO_DASHDASH=t UNTIL_DASHDASH=t eval "$(runWithPrompt --addAliasSupport eachArg \
    '' \
    'no-color' \
    '' \
    'color|progress|between-command'
)"
NO_DASHDASH=t UNTIL_DASHDASH=t eval "$(runWithPrompt --addAliasSupport eachDir \
    'l' \
    'local-dir|no-color' \
    'P' \
    'color|progress|predicate-command|between-command'
)"
NO_DASHDASH=t UNTIL_DASHDASH=t eval "$(runWithPrompt --addAliasSupport eachFile \
    'l1bv' \
    'local-dir|single|basename|with-header|with-basename-header|separate-errors|no-color|verbose' \
    'docfma' \
    'color|progress|ustrip|rebase|splice|default|modify|add|between-command'
)"
eval "$(runWithPrompt --addAliasSupport eachSplit \
    '' \
    'separate-errors|no-color' \
    '' \
    'splitter|progress|color|section-info-extractor'
)"
eval "$(runWithPrompt --addAliasSupport onfile \
    '1DS' \
    'accept-existing|stop-on-empty-dir|stop-on-empty-file|delete-empty-file|bare|no-capture-output|parallel|delete-on-success|delete-on-failure' \
    'dgnilst' \
    'dir|glob|source-command|count|delay|stabilization-time|interval|max-files|stop-on-filename|stop-after|prefix-command|prefix-command-command|parallel-limit|rate-limit|delete-on|delete-unless'
)"
INITIAL_ARGUMENT_COUNT=1 eval "$(runWithPrompt --addAliasSupport withAccessibleFile \
    'r' \
    'read' \
    'gmo' \
    'group|mode|owner'
)"
# Note: Aim for support of NAME=ALIAS-COMMAND (once);
# --alias ALIAS-COMMAND [...] ; cannot be parsed right now with addAliasSupport.
INITIAL_ARGUMENT_COUNT=1 eval "$(runWithPrompt --addAliasSupport withAliasedCommand \
    '' \
    'bare' \
    'n' \
    'name|alias|alias-command'
)"
eval "$(runWithPrompt --addAliasSupport withCwdPrependedToOutput \
    '' \
    '' \
    '' \
    ''
)"
eval "$(runWithPrompt --addAliasSupport withDeltaCommand \
    'E' \
    'output-at-end|bare' \
    'dDs' \
    'delta-command|delta-exec|sink-command|sink-exec'
)"
eval "$(runWithPrompt --addAliasSupport withDiff \
    '' \
    'no-color|bare' \
    '' \
    'for|color'
)"
INITIAL_ARGUMENT_COUNT=1 eval "$(runWithPrompt --addAliasSupport withDir \
    '' \
    'bare' \
    '' \
    ''
)"
eval "$(runWithPrompt --addAliasSupport withFallbackPath \
    'D' \
    'drop|bare' \
    '' \
    'for'
)"
INITIAL_ARGUMENT_COUNT=1 eval "$(runWithPrompt --addAliasSupport withHome \
    '' \
    '' \
    '' \
    ''
)"
INITIAL_ARGUMENT_COUNT=1 eval "$(runWithPrompt --addAliasSupport withLogging \
    'Tat12' \
    'timestamp|human|short|sortable|no-millis|append|tee|stdout|stderr' \
    'sfd' \
    'separator|field-separator|date|prefix'
)"
eval "$(runWithPrompt --addAliasSupport withOutputToSink \
    't12' \
    'tee|stdout|stderr' \
    'sS' \
    'sink-command|sink-exec'
)"
eval "$(runWithPrompt --addAliasSupport withOutputToSinkBasedOnMatch \
    't12' \
    'tee|stdout|stderr' \
    'mMvVsS' \
    'match-command|match-exec|no-match-command|no-match-exec|sink-command|sink-exec'
)"
eval "$(runWithPrompt --addAliasSupport withOutputToSinkBasedOnStatus \
    't12' \
    'tee|stdout|stderr' \
    'sS' \
    'success-command|success-exec|fail-command|fail-exec|status-command|status-exec'
)"
INITIAL_ARGUMENT_COUNT=1 eval "$(runWithPrompt --addAliasSupport withPath \
    'CiI' \
    'clean|ignore-noop|invert' \
    'pPm' \
    'path|path-file|partial'
)"
eval "$(runWithPrompt --addAliasSupport withPid \
    '' \
    '' \
    's' \
    'source-command'
)"
eval "$(runWithPrompt --addAliasSupport withTempfile \
    'mMrRkK' \
    'move|move-on-success|move-on-failure|rename|rename-on-success|rename-on-failure|keep|keep-on-success|keep-on-failure' \
    'pn' \
    'tmpdir|name'
)"
eval "$(runWithPrompt --addAliasSupport withVisualizedStatus \
    'iICloO' \
    'icon|no-icon|color|no-color|full-command|output|no-output' \
    'mkMns' \
    'message|success-message|fail-message|message-for|command-name'
)"

addAliasSupport tempdir \
    'k' \
    'keep|keep-on-success|keep-on-failure|stdin' \
    'dCn' \
    'or-existing|create-subdir|name'

addAliasSupport tempedit \
    'pPCv' \
    'print|no-print|verbose|cleanup|edit-empty' \
    'dbe' \
    'directory|basename|extension'

addAliasSupport tempfileAndEdit \
    'Cv' \
    'cleanup|verbose|edit-empty' \
    'dbe' \
    'directory|basename|extension'

addAliasSupport tempfileAndOpen \
    'Cv' \
    'cleanup|verbose' \
    'dbe' \
    'directory|basename|extension'

addAliasSupport tempfile \
    'qv' \
    'quiet|verbose' \
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

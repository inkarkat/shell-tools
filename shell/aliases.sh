#!/bin/sh source-this-script

COMMAND_PARAM_NAMES='@(--command|-c|--@(setup|reset|clean|fallback)-command)' EXEC_PARAM_NAMES='@(--exec|--@(setup|reset|clean|fallback)-exec)' \
    eval "$(runWithPrompt --addAliasSupport compareRuns \
	'12STt' \
	'ignore-status|ignore-time|run[12]|stdout|stderr|tee' \
	'' \
	'subject'
    )"
COMMAND_PARAM_NAMES='--?(between-)command' EXEC_PARAM_NAMES='--?(between-)exec' NO_DASHDASH=t UNTIL_DASHDASH=t \
    eval "$(runWithPrompt --addAliasSupport eachArg \
	'' \
	'no-color' \
	'' \
	'color|progress'
    )"
COMMAND_PARAM_NAMES='--?(between-|predicate-)command' EXEC_PARAM_NAMES='--?(between-|predicate-)exec' NO_DASHDASH=t UNTIL_DASHDASH=t \
    eval "$(runWithPrompt --addAliasSupport eachDir \
	'l' \
	'local-dir|no-color' \
	'P' \
	'color|progress'
    )"
COMMAND_PARAM_NAMES='--?(between-)command' EXEC_PARAM_NAMES='--?(between-)exec' NO_DASHDASH=t UNTIL_DASHDASH=t \
    eval "$(runWithPrompt --addAliasSupport eachFile \
	'l1bv' \
	'local-dir|single|basename|with-header|with-basename-header|separate-errors|no-color|verbose' \
	'docfma' \
	'color|progress|ustrip|rebase|splice|default|modify|add'
    )"
eval "$(runWithPrompt --addAliasSupport eachSplit \
    '' \
    'separate-errors|no-color' \
    '' \
    'splitter|progress|color|section-info-extractor'
)"
COMMAND_PARAM_NAMES='--?(prefix-|prefix-command-|source-)command' EXEC_PARAM_NAMES='--?(prefix-|prefix-command-|source-)exec' \
    eval "$(runWithPrompt --addAliasSupport onfile \
	'1DS' \
	'accept-existing|stop-on-empty-dir|stop-on-empty-file|delete-empty-file|bare|no-capture-output|parallel|delete-on-success|delete-on-failure' \
	'dgnilst' \
	'dir|glob|count|delay|stabilization-time|interval|max-files|stop-on-filename|stop-after|parallel-limit|rate-limit|delete-on|delete-unless'
    )"
INITIAL_ARGUMENT_COUNT=1 eval "$(runWithPrompt --addAliasSupport withAccessibleFile \
    'r' \
    'read' \
    'gmo' \
    'group|mode|owner'
)"
# Note: Aim for support of NAME=ALIAS-COMMAND (once);
# --alias ALIAS-COMMAND [...] ; cannot be parsed right now with addAliasSupport.
COMMAND_PARAM_NAMES='--?(alias-)command' EXEC_PARAM_NAMES='--?(alias-)exec' INITIAL_ARGUMENT_COUNT=1 \
    eval "$(runWithPrompt --addAliasSupport withAliasedCommand \
	'' \
	'bare' \
	'n' \
	'name|alias'
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
    '@(delta|sink)-@(command|exec)'
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
COMMAND_PARAM_NAMES='@(--command|-c|--sink-command|-s)' EXEC_PARAM_NAMES='@(--exec|--sink-exec|-S)' \
    eval "$(runWithPrompt --addAliasSupport withOutputToSink \
	't12' \
	'tee|stdout|stderr' \
	'' \
	''
    )"
COMMAND_PARAM_NAMES='@(--command|-c|--match-command|-m|--no-match-command|-v|--default-command|-d)' EXEC_PARAM_NAMES='@(--exec|--match-exec|-M|--no-match-exec|-V|--default-exec|-D)' \
    eval "$(runWithPrompt --addAliasSupport withOutputToSinkBasedOnMatch \
	't12' \
	'tee|stdout|stderr' \
	'' \
	''
    )"
    COMMAND_PARAM_NAMES='@(--command|-c|--@(success|fail|status|default)-command|-s)' EXEC_PARAM_NAMES='@(--exec|--@(success|fail|status|default)-exec|-S)' \
    eval "$(runWithPrompt --addAliasSupport withOutputToSinkBasedOnStatus \
	't12' \
	'tee|stdout|stderr' \
	'' \
	''
    )"
INITIAL_ARGUMENT_COUNT=1 eval "$(runWithPrompt --addAliasSupport withPath \
    'CiI' \
    'clean|ignore-noop|invert' \
    'pPm' \
    'path|path-file|partial'
)"
COMMAND_PARAM_NAMES='--?(source-)command|-s' EXEC_PARAM_NAMES='--?(source-)exec|-S' \
    eval "$(runWithPrompt --addAliasSupport withPid \
	'' \
	'' \
	'' \
	''
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

COMMAND_PARAM_NAMES='@(--command|-c|--sink-command|-s)' EXEC_PARAM_NAMES='@(--exec|--sink-exec|-S)' \
    addAliasSupport tempedit \
	'pPCv' \
	'print|no-print|verbose|cleanup|edit-empty' \
	'dbe' \
	'directory|basename|extension'

COMMAND_PARAM_NAMES='@(--command|-c|--sink-command|-s)' EXEC_PARAM_NAMES='@(--exec|--sink-exec|-S)' \
    addAliasSupport tempfileAndEdit \
	'Cv' \
	'cleanup|verbose|edit-empty' \
	'dbe' \
	'directory|basename|extension'

COMMAND_PARAM_NAMES='@(--command|-c|--sink-command|-s)' EXEC_PARAM_NAMES='@(--exec|--sink-exec|-S)' \
    addAliasSupport tempfileAndOpen \
	'Cv' \
	'cleanup|verbose' \
	'dbe' \
	'directory|basename|extension'

COMMAND_PARAM_NAMES='@(--command|-c|--sink-command|-s)' EXEC_PARAM_NAMES='@(--exec|--sink-exec|-S)' \
    addAliasSupport tempfile \
	'qv' \
	'quiet|verbose' \
	'dbesS' \
	'directory|basename|extension|sink-command|sink-exec'

COMMAND_PARAM_NAMES='@(--command|-c|--sink-command|-s)' EXEC_PARAM_NAMES='@(--exec|--sink-exec|-S)' \
    addAliasSupport withEditorAndPager
COMMAND_PARAM_NAMES='@(--command|-c|--sink-command|-s)' EXEC_PARAM_NAMES='@(--exec|--sink-exec|-S)' \
    addAliasSupport withEditor
COMMAND_PARAM_NAMES='@(--command|-c|--sink-command|-s)' EXEC_PARAM_NAMES='@(--exec|--sink-exec|-S)' \
    addAliasSupport withPager

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

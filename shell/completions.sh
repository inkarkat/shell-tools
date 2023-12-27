#!/bin/sh source-this-script

completeAsCommand commandlineToShellCommand \
    eachArg eachDir eachFile \
    exitsWith onfile \
    processAddedFiles replify reverseFileArgs slowcommand sortedFileArgs \
    tempdir tempedit tempfileAndEdit tempfile \
    withAccessibleFile withAliasedCommand withDir withFirstExistingFile withHome withLoggingTo withOutputToSink withPath withPid withTempfile withVisualizedStatus

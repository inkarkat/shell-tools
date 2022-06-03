#!/bin/sh source-this-script

completeAsCommand commandlineToShellCommand \
    eachArg eachDir eachFile \
    exitsWith onfile \
    processAddedFiles replify reverseFileArgs slowcommand sortedFileArgs \
    tempdir tempfile \
    withAccessibleFile withDir withHome withLoggingTo withOutputToSink withPath withPid withTempfile withVisualizedStatus

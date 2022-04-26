#!/bin/sh source-this-script

completeAsCommand commandlineToShellCommand \
    eachArg eachFile \
    exitsWith onfile \
    processAddedFiles replify reverseFileArgs slowcommand sortedFileArgs \
    tempdir tempfile \
    withAccessibleFile withDir withHome withPath withPid withTempfile

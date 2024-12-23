# Shell Tools

_A collection of shell scripts that are either useful on its own (in interactive sessions), or offer generic functionality for higher-level scripts._

![Build Status](https://github.com/inkarkat/shell-tools/actions/workflows/build.yml/badge.svg)

Similar to the Shell Basics, these are more elaborate and/or specialized.

### Dependencies

* Bash, GNU `sed`
* [inkarkat/run](https://github.com/inkarkat/run) for the `--with-prompt` flag
* [inkarkat/shell-user-interactions](https://github.com/inkarkat/shell-user-interactions) for the `--progress` parameter
* [inkarkat/headers](https://github.com/inkarkat/headers) for the `--with-header` flag
* automated testing is done with _bats - Bash Automated Testing System_ (https://github.com/bats-core/bats-core)

### Installation

* The `./bin` subdirectory is supposed to be added to `PATH`.
* The [shell/aliases.sh](shell/aliases.sh) script (meant to be sourced in `.bashrc`) defines Bash aliases around the provided commands.
* The [shell/completions.sh](shell/completions.sh) script (meant to be sourced in `.bashrc`) defines Bash completions for the provided commands.
* The [profile/exports.sh](profile/exports.sh) sets up configuration; it only needs to be sourced once, e.g. from your `.profile`.

#!/usr/bin/env fish

# CMDFILE global variables
set -gx CMDFILE_VERSION "0.0.1"
set -gx CMDFILE_HELP_PATH (realpath (dirname (status --current-filename))/help.txt)
set -gx CMDFILE_CONFIG_PATH (realpath (dirname (status --current-filename))/cmd.yml)

# Load all functions for cmdfile to work
for file in parser/parse_*.fish
    echo "Loading $file"
    source $file
end

function cmdfile -d "Command line tool"
    set -l arguments (cmdfile_parse_args $argv)

    if echo $arguments | yq e '.flags | has("help")' - | string match -q true
        cat $CMDFILE_HELP_PATH
        return 0
    end

    if echo $arguments | yq e '.flags | has("version")' - | string match -q true
        echo $CMDFILE_VERSION
        return 0
    end

    if test (echo $arguments | yq e '.aliases | length' - | count -gt 0)
        echo "HAS ALIASES !!! $argv"
        return 0
    end
end

alias cmd="cmdfile"

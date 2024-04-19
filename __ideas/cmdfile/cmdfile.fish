#!/usr/bin/env fish

# CMDFILE global variables
set --global --export CMDFILE_VERSION "0.0.1"
set --global --export CMDFILE_CONFIG_PATH (realpath (dirname (status --current-filename))/cmd.yml)

function cmdfile -d "Command line tool"
    sources "functions/parser"

    set --local arguments (parse_args $argv)

    if echo $arguments | yq e '.flags | (has("h") or has("help"))' - | string match -q true
        cat $CMDFILE_HELP_PATH/cmd.txt
        return 0
    end

    if echo $arguments | yq e '.flags | (has("v") or has("version"))' - | string match -q true
        echo $CMDFILE_VERSION
        return 0
    end

    if test (echo $arguments | yq e '.aliases | length' - | count -gt 0)
        echo "HAS ALIASES !!! $argv"
        return 0
    end
end

#!/usr/bin/env fish

# STILL NEEDs WORK

function npm --description "Unified command for JavaScript package managers"
    dependencies node jq
    sources

    set --local package_manager (find_package_manager)
    return 0

    command $package_manager $argv
end

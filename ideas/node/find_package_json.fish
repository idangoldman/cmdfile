#!/usr/bin/env fish

function find_package_json --description "Find a package.json file in the current directory or its parent directories"
    set package_json_file "package.json"
    set current_dir (pwd)

    while test "$current_dir" != /
        set current_package_json "$current_dir/$package_json_file"

        if test -f "$current_package_json"
            echo "$current_package_json"
            return 0
        end

        set current_dir (dirname "$current_dir")
    end

    echo ""
    return 0
end

function find_package_path --argument path
    set -l current_path $path

    while test -n $current_path
        if test -e $current_path/package.json
            echo $current_path
            return
        end
        set -l current_path (dirname $current_path)
    end

    echo "Node package root directory not found" >&2
    return 1
end

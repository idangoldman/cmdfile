#!/usr/bin/env fish

function find_by_lock_file --description "Find the package manager for the current folder by lock file" --argumen-names current_folder
    # Single string with lock file and command pairs, separated by ':'
    set --local package__lock (
    'pnpm:pnpm-lock.yaml'
    'yarn:yarn.lock'
    'npm:package-lock.json'
    'deno:deno.lock'
    'bun:bun.lockb'
  )

    for pair in $package__lock
        # Split the pair into lock file and command
        set --local key_value (string split ':' $pair)
        set --local package_manager $key_value[1]
        set --local lock_file $key_value[2]

        if test -f $current_folder/$lock_file
            echo $package_manager
            return 0
        end
    end

    return 1
end

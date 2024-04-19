#!/usr/bin/env fish

function find_by_package_file --description 'Find the node engine in a package.json file' --argument-names package_json

    if test -f -r $package_json
        set --local found_engines (jq -r '.engines | keys | join(" ")' $package_json)
        set --local engines pnpm yarn npm node deno bun

        for engine in $engines
            if test contains $engine $found_engines
                echo $engine
                return 0
            end
        end
    end

    return 1
end

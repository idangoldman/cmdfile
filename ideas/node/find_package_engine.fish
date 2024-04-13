#!/usr/bin/env fish

function find_package_engine --description 'Find the node engine in a package.json file'
  set package_json_file args[1]

  if test -n "$package_json_file"
    set found_engines (jq -r '.engines | keys | join(", ")' "$package_json_file")
    set engines_list pnpm yarn npm node deno bun

    for engine in $engines_list
      if string match -r "$engine" "$found_engines"
        echo "$engine"
        return 0
      end
    end
  end

  echo ""
  return 0
end

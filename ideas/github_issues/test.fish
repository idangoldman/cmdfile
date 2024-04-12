#!/usr/bin/env fish

for file in ../../packages/utilities/*.fish
    echo "Loading $file"
    source $file
end

dependencies mkdir touch gh gawk yq jq

# exists_or_create folder blah
# exists_or_create file dude/blah.txt

# source ./md_to_yaml.fish

# set --local yaml_file_path (md_to_yaml .github/issues/feature-request-add-user-login-functionality.md)

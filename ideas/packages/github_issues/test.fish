#!/usr/bin/env fish

source ./md_to_yaml.fish

# set --local example_file (md_to_yaml .github/issues/feature-request-add-user-login-functionality.md)

# yq -e '.labels' (md_to_yaml .github/issues/feature-request-add-user-login-functionality.md)
# echo $example_file | yq e '.labels' -

set --local yaml_file_path (md_to_yaml .github/issues/feature-request-add-user-login-functionality.md)


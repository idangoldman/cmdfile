#!/usr/bin/env fish

dependencies mkdir touch gh gawk yq jq
sources "../../packages/utilities" "md_to_yaml.fish"

# set --local yaml_file_path (md_to_yaml .github/issues/feature-request-add-user-login-functionality.md)

#!/usr/bin/env fish

# STILL NEEDs WORK

# function npm --description "Unified command for JavaScript package managers"
#   set package_manager "npm"
#   set package_json_file (find_package_json_file)

#   if test -f $package_json_file
#     set package_engine (find_package_engine $package_json_file)

#     if test -z $package_engine
#       set package_engine (find_package_lock $package_json_file)
#     end

#     if test -n $package_engine
#       set package_manager $package_engine
#     end
#   end

#   command $package_manager $argv
# end

# find if command exists with which or command or something...


# function npm --description "Unified command for JavaScript package managers"
#     if test -f pnpm-lock.yaml
#         command pnpm $argv
#     else if test -f yarn.lock
#         command yarn $argv
#     else if test -f package-lock.json
#         command npm $argv
#     else if test -f deno.lock
#         command deno $argv
#     else if test -f bun.lockb
#         command bun $argv
#     else
#         command pnpm $argv
#     end
# end

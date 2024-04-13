#!/usr/bin/env fish

function find_package_lock
  # Single string with lock file and command pairs, separated by ':'
  set package_lock (
    'pnpm:pnpm-lock.yaml'
    'yarn:yarn.lock'
    'npm:package-lock.json'
    'deno:deno.lock'
    'bun:bun.lockb'
  )

  for pair in $package_lock
    # Split the pair into lock file and command
    set -l key_value (string split ':' $pair)
    set -l package_manager $key_value[1]
    set -l lock_file $key_value[2]

    if test -f $lock_file
      echo "$package_manager"
      return 0
    end
  end

  echo ""
  return 0
end

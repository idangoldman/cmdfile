# Usage:
# envfile [file] [--unset]

function envfile
  set -l file $argv[1]
  set -l unset_flag $argv[2]

  if test -z "$file"
    set -l current_folder_envfile (pwd)/.env

    if test -f $current_folder_envfile
      set -l file $current_folder_envfile
    else
      echo "No environment file found in the current folder."
      return
    end
  end

  if test -f $file
    while read -r line
      # Skip empty lines and comments
      if test -n "$line" -a "$line" != "#*"
        set -l key (string split -m1 "=" $line)[1]
        set -l value (string split -m1 "=" $line)[2]

        if test "$unset_flag" = --unset
          set -e key
        else
          set -gxU $key $value
        end
      end
    end <$file
  else
    echo "File not found: $file"
  end
end

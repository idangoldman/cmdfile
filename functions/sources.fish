function sources --description 'Source all files in the given list of arguments'
    set --local current_file (realpath (status filename))
    set --local caller_file (realpath (status stack-trace | awk '/file/ {file=$NF} END {print file}'))
    set --local base_folder (realpath (dirname $caller_file))
    set --local --path paths $base_folder/*.fish

    if test (count $argv) -gt 0
        set --path paths

        for path in $argv
            if test -d $path
                set --append paths (realpath $path/*.fish)
            end

            if test -f $path
                set --append paths (realpath $path)
            end
        end
    end

    for path in $paths
        if not contains $path $current_file $caller_file
            source $path
            # echo "Sourced: $path"
        end
    end
end

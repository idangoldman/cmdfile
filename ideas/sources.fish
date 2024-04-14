function sources --description 'Source all files in the given list of arguments'
    set --local current_file (realpath (status filename))
    set --local caller_file (realpath (status stack-trace | awk '/file/ {file=$NF} END {print file}'))
    set --local base_folder (realpath (dirname $caller_file))
    set --local paths .

    if test (count $argv) -gt 0
        set paths $argv
    end

    # for file in (ls $paths)
    for file in $paths
        set --local absolute_path (realpath (dirname $base_folder/$file))
        set --local filename (basename $file)
        set --local full_path $absolute_path/$filename

        echo "Absolute:"
        echo $full_path
        echo "Current:"
        echo $current_file
        echo "Caller:"
        echo $caller_file

        if test "$full_path" != "$current_file" -a "$full_path" != "$caller_file" -a -r "$full_path"
            begin
                source $full_path
                echo "Sourced: $full_path"
            end
        end
    end
end

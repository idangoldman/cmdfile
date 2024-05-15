function find_parent_folder --description 'Find the target path in the source path' --argument-names source_path target_folder
    set --local regex_path "(?<found_folder>.*\/$target_folder\/?)"
    set source_path (realpath $source_path)

    if test -f $source_path
        set source_path (dirname $source_path)
    end

    if string match --quiet --regex --ignore-case --groups-only $regex_path $source_path
        echo $found_folder
        return 0
    end

    echo "Folder '$target_folder' not found in '$source_path'"
    return 1
end

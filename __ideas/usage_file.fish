function usage_file --on-event usage_file
    set --local usage_file_path "$cmdfile_path/usage/$filename.txt"

    if test -r $usage_file_path
        cat $usage_file_path
    else
        echo "Usage file not found: $usage_file_path" >&2
        return 1
    end
end

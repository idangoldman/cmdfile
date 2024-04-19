function manual_file --on-event manual_file
    set --local manual_file_path "$CMDFILE_MANUALS_PATH/$filename.txt"

    if test -r $manual_file_path
        cat $manual_file_path
    else
        echo "Usage file not found: $manual_file_path" >&2
        return 1
    end
end

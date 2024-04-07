function cmdfile_config_find
    set --local found_paths
    set --local current_dir (pwd -P)

    if test -f "$current_dir/$CMDFILE_CONFIG_NAME"
        set --append found_paths "$current_dir/$CMDFILE_CONFIG_NAME"
    end

    if test -f "$CMDFILE_USER_DIR/$CMDFILE_CONFIG_NAME"
        set --append found_paths "$CMDFILE_USER_DIR/$CMDFILE_CONFIG_NAME"
    end

    if test (count $found_paths) -eq 0
        echo "No configuration file found."
        exit 1
    else if test (count $found_paths) -gt 1
        echo $found_paths[1]
    else
        echo $found_paths
    end
end

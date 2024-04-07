function cmdfile_config_merged
    set -l merged_content
    set -l found_paths (cmdfile_config_find)

    if count $found_paths >0
        set merged_content (yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' $found_paths)
    end

    echo $merged_content
end

function cmdfile_functions_load
    if not contains $CMDFILE_FUNCTIONS_PATH $fish_function_path
        set -a fish_function_path $CMDFILE_FUNCTIONS_PATH
    end
end

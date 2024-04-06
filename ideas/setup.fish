function cmdfile_setup
    set -gx CMDFILE_NAME "cmd.yml"
    set -gx CMDFILE_VERSION "0.0.1"
    set -gx CMDFILE_USER_DIR (cmdfile_config_dir)
    set -gx CMDFILE_SESSION_CONFIG (cmdfile_config_merged)
    set -gx CMDFILE_FUNCTIONS_PATH "$CMDFILE_USER_DIR/functions"

    # TODO: test that it's actually works
    # cmdfile_check_for_dependencies
end

function cmdfile_config_find
    set -l found_paths
    set -l current_dir (pwd -P)

    while test "$current_dir" != /
        if test -f "$current_dir/$CMDFILE_NAME"
            set found_paths "$current_dir/$CMDFILE_NAME" $found_paths
        end
        set current_dir (dirname $current_dir)
    end

    if test -f "$CMDFILE_USER_DIR/$CMDFILE_NAME"
        set found_paths "$CMDFILE_USER_DIR/$CMDFILE_NAME" $found_paths
    end

    if count $found_paths >0
        printf "%s\n" $found_paths
    else
        echo "cmd.yml not found in any searched locations."
        exit 1
    end
end

function cmdfile_config_merged
    set -l merged_content
    set -l found_paths (cmdfile_config_find)

    if count $found_paths >0
        set merged_content (yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' $found_paths)
    end

    echo $merged_content
end

function cmdfile_config_dir
    set -l user_dir "$HOME/.cmd"

    if set -q XDG_CONFIG_HOME
        set user_dir "$XDG_CONFIG_HOME/cmd"
    end

    if not test -d $user_dir
        mkdir -p $user_dir
    end

    echo $user_dir
end

function cmdfile_check_for_dependencies
    set -l dependencies (yq --version)
    set -l dependencies (jq --version)
    set -a dependencies (gzip --version)

    for dep in $dependencies
        if not test -n $dep
            echo "Dependency $dep not found."
            exit 1
        end
    end
end

function cmdfile_functions_load
    if not contains $CMDFILE_FUNCTIONS_PATH $fish_function_path
        set -a fish_function_path $CMDFILE_FUNCTIONS_PATH
    end
end

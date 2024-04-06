function cmdfile_setup
    cmdfile_check_for_dependencies

    set -gx CMDFILE_CONFIG_NAME "cmd.yml"
    set -gx CMDFILE_CONFIG_NAMES "cmd.yml" "cmdfile.yml" "cmd.yaml" "cmdfile.yaml"
    set -gx CMDFILE_VERSION "0.0.1"
    set -gx CMDFILE_USER_DIR (cmdfile_config_dir)
end

function cmdfile_check_for_dependencies
    set -l dependencies yq gzip
    set -l dependency_not_found 0

    for dependency in $dependencies
        if test -z (which $dependency)
            echo "Dependency $dependency not found."
            set dependency_not_found 1
        end
    end

    if test $dependency_not_found -eq 1
        exit 1
    end
end

function cmdfile_config_dir
    set -l basename cmdfile
    set -l user_dir "~/.$basename"

    if set -q HOME
        set user_dir "$HOME/.$basename"
    end

    if set -q XDG_CONFIG_HOME
        set user_dir "$XDG_CONFIG_HOME/$basename"
    end

    if not test -d $user_dir
        echo "Creating $user_dir"
        mkdir -p $user_dir
    end

    echo $user_dir
end

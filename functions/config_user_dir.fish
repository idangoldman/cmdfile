function cmdfile_config_user_dir
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

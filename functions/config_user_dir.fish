function cmdfile_config_user_dir
    set --local basename cmdfile
    set --local user_dir "~/.$basename"

    if set --query HOME
        set user_dir "$HOME/.$basename"
    end

    if set --query XDG_CONFIG_HOME
        set user_dir "$XDG_CONFIG_HOME/$basename"
    end

    if not test -d $user_dir
        echo "Creating $user_dir"
        mkdir --parents $user_dir
    end

    echo $user_dir
end

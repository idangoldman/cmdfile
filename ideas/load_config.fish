function load_config
    set -l config_file $argv
    if test -r $config_file
        source $config_file
    else
        echo "Configuration file $config_file not found."
        exit 1
    end
end

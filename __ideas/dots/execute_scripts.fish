function execute_scripts
    for script in (yq e '.scripts[] | select(.type == "shell") | .command' $config_file)
        eval $script
        echo "Executed: $script"
    end
end

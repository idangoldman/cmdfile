function create_directories
    for dir in (yq e '.directories[] | select(.type == "directory") | .path' $config_file)
        if not test -d $dir
            mkdir -p $dir
            echo "Created directory: $dir"
        else
            echo "Directory already exists: $dir"
        end
    end
end

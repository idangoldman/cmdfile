function clean_files
    for file in (yq e '.clean[] | select(.type == "clean") | .target' $config_file)
        if test -e $file
            rm -r $file
            echo "Removed: $file"
        else
            echo "File or directory not found for removal: $file"
        end
    end
end

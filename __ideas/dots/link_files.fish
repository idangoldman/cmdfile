function link_files
    for line in (yq e '.dotfiles[] | select(.type == "link") | .source + " " + .target' $config_file)
        set source_file $dotfiles_dir/(echo $line | awk '{print $1}')
        set target_file (echo $line | awk '{print $2}')

        if test -e $target_file -a ! test -L $target_file
            echo "Backup needed for: $target_file"
            mv $target_file $target_file".dot.bak"
        end

        if not test -L $target_file
            ln -s $source_file $target_file
            echo "Linked $source_file to $target_file"
        else
            echo "Symlink already exists: $target_file"
        end
    end
end

function link_files
    for line in (yq e '.dotfiles[] | select(.type == "link") | .source + " " + .target' $config_file)
        set source_file $dotfiles_dir/(echo $line | awk '{print $1}')
        set target_file (echo $line | awk '{print $2}')

        echo "Linking $source_file to $target_file"
        if not $dry_run
            if not test -L $target_file
                ln -s $source_file $target_file
            else
                echo "Symlink already exists: $target_file"
            end
        end
    end
end

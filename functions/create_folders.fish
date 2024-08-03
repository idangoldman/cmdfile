function create_folders --description 'Create folders via a list of paths'
    # if `--trailing` flag exists, it will create folders based on the last path segment
    argparse 't/trailing' -- $argv or return

    set --local folders $argv

    for folder in $folders
        if set --query _flag_trailing; and not string match --quiet --regex '.+/$' $folder
            set folder (dirname $folder)
        end

        create_folder $folder
    end
end

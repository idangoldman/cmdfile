function create_folders --description 'Create folders via a list of paths'
    argparse trailing --description 'Default: false, if true, will create folders by the last trailing slash in each the path' -- $argv

    set --local folders $argv

    for folder in $folders
        if set --query _flag_trailing; and not string match --quiet --regex '.+/$' $folder
            set folder (dirname $folder)
        end

        create_folder $folder
    end
end

function create_folder --description 'Create a folder if it does not exist' --argument-names folder

    # TODO: Implement --follow (cd command) flag to change directory to the newly created folder
    # argparse 'f/follow' -- $argv
    # ex: create_folder --follow /path/to/folder

    if test -z $folder
        echo "Folder path is required"; and return 1
    end

    if not test -e $folder
        mkdir -p $folder
    end

    echo (realpath $folder); and return 0
end

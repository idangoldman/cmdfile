function create_folder --description 'Create a folder if it does not exist' --argument-names folder
    if test -z $folder
        echo "Folder path is required"; and return 1
    end

    if not test -e $folder
        mkdir -p $folder
    end

    echo (realpath $folder); and return 0
end

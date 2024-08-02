function create_file --description 'Create a file if it does not exist' --argument-names file
    if test -z $file
        echo "File path is required"; and return 1
    end

    if not test -e $file
        create_folder (dirname $file) > /dev/null
        touch $file
    end

    echo (realpath $file); and return 0
end

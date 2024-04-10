function create_folder --description 'Create a folder if it does not exist'
    set --local folder = $argv[1]

    if not test --directory $folder
        mkdir --parents $folder
    end

    echo $folder
end

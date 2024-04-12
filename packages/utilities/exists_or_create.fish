function exists_or_create --description "Create a folder if it does not exist" --argument-names type path
    if test -e $path
        echo $path
        return 0
    end

    switch $type
        case 'file'
          create_file $path
          return 0
        case 'folder'
          create_folder $path
          return 0
        case '*'
            echo "Invalid type: $type"
            return 1
    end
end

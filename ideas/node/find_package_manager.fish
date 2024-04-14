function find_package_manager --description "Find the package manager for the current directory"
    set --local current_folder $PWD

    while test $current_folder != /
        find_by_lock_file $current_folder; and return 0
        find_by_package_file $current_folder; and return 0

        set --local current_folder (dirname $current_folder)
    end

    echo npm; and return 0
end

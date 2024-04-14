function dependencies --description "Check if dependencies are installed"
    set --local dependency_not_found 0

    for dependency in $argv
        if test -z (which $dependency)
            echo "Dependency $dependency not found. Please install it before proceeding."
            set dependency_not_found 1
        end
    end

    if test $dependency_not_found -eq 1
        return 1
    end
end

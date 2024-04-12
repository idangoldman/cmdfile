function dependencies --description "Check if dependencies are installed"
    set --local dependency_not_found 0

    for dependency in $argv
        if test -z (which $dependency)
            echo "Dependency $dependency not found."
            set dependency_not_found 1
        end
    end

    if test $dependency_not_found -eq 1
        exit 1
    end
end

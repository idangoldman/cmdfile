function cmdfile_check_for_dependencies
    set -l dependencies yq gzip cat grep
    set -l dependency_not_found 0

    for dependency in $dependencies
        if test -z (which $dependency)
            echo "Dependency $dependency not found."
            set dependency_not_found 1
        end
    end

    if test $dependency_not_found -eq 1
        exit 1
    end
end

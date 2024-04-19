function dependencies --description "Check for existence of dependencies, and return 1 on the first missing one"
    for command in $argv
        if not type --query $command
            echo "Command `$command` not found. Please install it before proceeding." >&2
            return 1
        end
    end
end

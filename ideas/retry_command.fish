function retry_command
    set -l attempt 0
    set -l max_attempts $argv[1]
    set -l command $argv[2]

    while test $attempt -lt $max_attempts
        eval $command
        if test $status -eq 0
            return 0
        end
        echo "Attempt $attempt failed, retrying..."
        set -l attempt (math $attempt + 1)
    end
    echo "Command failed after $max_attempts attempts."
    return 1
end

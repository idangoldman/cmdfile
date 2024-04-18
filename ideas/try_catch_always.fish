function try
    set -l output (eval $argv 2>&1)
    set -l status $status
    set -g last_try_output $output
    set -g last_pipestatus $pipestatus

    if set -q TRY_ECHO_OUTPUT
        echo -e $output
    end

    return $status
end

function catch
    for err_code in $argv[1]
        if test $status -eq $err_code
            echo $argv[2]
            return $status
        end
    end

    if not test $status -eq 0
        echo $argv[-1]
        return $status
    end
end

function always
    eval $argv
    if not test $status -eq 0
        echo "Warning: `always` ​failed with status $status"
    end
end

function deploy
    try "git pull origin master"
    catch 128 "Error: Failed to authenticate." "General error during git pull."

    try "make deploy"
    catch 2 "Error: Makefile not found." "General build error."

    always "log 'Deployment completed with status $status'"
end

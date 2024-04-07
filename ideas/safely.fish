function cmd_run_safely
    set --local cmd (sanitize_and_escape $argv)
    set --local cmd_output (eval $cmd 2>&1 | string collect)
    set --local cmd_status $status

    if test $cmd_status -ne 0
        echo "Command failed with status $cmd_status: $output"
    else
        echo $output
    end
end

function sanitize_and_escape
    set sanitized (string replace -ra '[;&|$`]' '' -- $argv)

    string escape -- $sanitized
end

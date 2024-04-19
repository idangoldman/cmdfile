function time_command
    set -l start_time (date +%s)
    eval $argv
    set -l end_time (date +%s)
    echo "Command executed in (math $end_time - $start_time) seconds."
end

function monitor_usage
    set -l command $argv
    command time -v $command
end

function set_command_start_time --on-event fish_preexec
    set -g command_start_time (date +%s)
end

function show_command_elapsed_time --on-event fish_postexec
    set -l end_time (date +%s)
    set -l elapsed_time (math $end_time - $command_start_time)
    echo "Command '$argv' took $elapsed_time seconds to complete."
end

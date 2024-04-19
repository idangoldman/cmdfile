function wait_for --description 'Wait for a list of PIDs to finish'
    set --local pids $argv

    while count $pids >0
        for pid in $pids
            if not kill -0 $pid ^/dev/null
                set pids (string match -vr "\b$pid\b" $pids)
                break
            end
        end

        sleep 0.1
    end
end

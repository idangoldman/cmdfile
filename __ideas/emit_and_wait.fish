set --global event_response_data

function emit_and_wait_sleep
    set -e event_response_data
    emit my_custom_event "Send this payload"
    set -l timeout 1

    while not set -q event_response_data
        if test $timeout -le 0
            echo "Timeout waiting for response"
            return 1
        end
        echo "Waiting for response..."
        sleep 0.1
        set timeout (math $timeout - 0.1)
    end

    echo "Processing completed with response: $event_response_data"
end

function emit_and_wait_while_true
    set -e event_response_data
    emit my_custom_event "Send this payload"
    set -l start_time (date +%s)

    while true
        if set -q event_response_data
            echo "Processing completed with response: $event_response_data"
            return 0
        end

        set -l current_time (date +%s)
        if test (math "$current_time - $start_time") -ge 1
            echo "Timeout waiting for response"
            return 1
        end
    end
end

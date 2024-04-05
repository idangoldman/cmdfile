set -l cmdfile_delimiter '[===]'
set -l cmdfile_delimiter_key_value '[:::]'
set -l cmdfile_action_regex '^[a-zA-Z][a-zA-Z0-9_]*$'
set -l cmdfile_flag_key_regex '^-{1,2}(?P<flag>[a-zA-Z][a-zA-Z0-9_]*)$'
set -l cmdfile_key_value_regex '^(?P<key>[a-zA-Z][a-zA-Z0-9_]*)=(?P<value>[^=]+)$'
set -l cmdfile_variable_key_value_regex '^(?P<key>[A-Z][A-Z0-9_]*)=(?P<value>[^=]+)$'

function cmdfile_parse_argv
    set -l actions
    set -l options
    set -l variables
    set -l flags

    set -l found_non_action 0

    for arg in $argv
        set -l key_value (string match -qr -- $cmdfile_key_value_regex -- $arg)

        switch $arg
            case $cmdfile_flag_key_regex
                set found_non_action 1
                set flags "$flags (string match -qr -- $cmdfile_flag_key_regex -- $arg)"
            case $cmdfile_key_value_regex
                set found_non_action 1
                set key_value (cmdfile_parse_key_value $arg)

                if string match -qr $cmdfile_variable_key_regex -- $arg
                    set variables "$variables $arg"
                else if string match -qr '^[a-zA-Z][a-zA-Z0-9_]*$' -- $key_value[1]
                    set options "$options $key_value[1]:$key_value[2]"
                else
                    echo "Error: Invalid variable or option name: $key_value[1]"
                    return 1
                end
            case '*'
                if test $found_non_action = 1
                    echo "Error: Actions must come before options, variables, and flags"
                    return 1
                end

                set actions "$actions $arg"
        end
    end

    echo "$actions [===] $options [===] $variables [===] $flags"
end

function cmdfile_parse_arg_type
    set -l action_regex '^[a-zA-Z][a-zA-Z0-9_]*$'
    set -l flag_key_regex '^-{1,2}(?P<flag>[a-zA-Z][a-zA-Z0-9_]*)$'
    set -l key_value_regex '^(?P<key>[a-zA-Z][a-zA-Z0-9_]*)=(?P<value>[^=]+)$'
    set -l variable_key_value_regex '^(?P<key>[A-Z][A-Z0-9_]*)=(?P<value>[^=]+)$'

    set -l arg_type

    switch $argv[1]
        case $cmdfile_flag_key_regex
            set arg_type flag
        case $cmdfile_variable_key_value_regex
            set arg_type variable
        case $cmdfile_key_value_regex
            set arg_type option
        case '*'
            set arg_type action
    end

    echo $arg_type
end

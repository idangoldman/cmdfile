function cmdfile_parse_arg --description 'Parse command argument into type, key, and value. Return type, key, and value in a format that can be parsed by awk.'
    # regular expression for matching key-value pairs in options, variables, and flags
    set --local RE_FLAG_KEY_VALUE '^(?<dash>-{1,2})?(?<key>[a-z][a-z0-9_]*)(?:=(?<value>.+))?$'

    # regular expressions for matching keys of different types
    set --local RE_KEY '^[a-z][a-z0-9_]*$'
    set --local RE_VARIABLE_KEY '^[A-Z][A-Z0-9_]*$'

    # parse the passed argument into $key and $value variables
    string match --quiet --regex --ignore-case --groups-only $RE_FLAG_KEY_VALUE -- $argv

    # check if $key and $value are set
    if test $status -eq 1
        echo "Error: invalid argument $argv"
        return 1
    end

    # set default type to aliases
    set --local type aliases

    # patch for dash-only value in flags
    set --local flag_key false
    if set --query dash; and test -n "$dash"
        if test (string length -- $dash) -gt 0
            set flag_key true
        end
    end

    # set type based on key and value
    if test $flag_key = true
        set type flags
        set value (test -n "$value"; and echo $value; or echo true)
    else if test -n "$value"
        if string match --quiet --regex $RE_VARIABLE_KEY $key
            set type variables
        else if string match --quiet --regex --ignore-case $RE_KEY $key
            set type options
        end
    end

    # echo argument in a format that can be parsed by awk
    # echo "$type | $key => $value"
    echo $type $key $value
end

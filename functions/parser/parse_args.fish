function parse_args --description 'Parse arguments into a JSON object using yq'
    set --local arguments "{aliases: [], options: {}, variables: {}, flags: {}}"
    set --local found_non_alias 0

    for argument in $argv
        set --local parsed_argument (parse_arg $argument)

        set --local type (echo $parsed_argument | awk '{print $1}')
        set --local key (echo $parsed_argument | awk '{print $2}')
        set --local value (echo $parsed_argument | awk '{print $3}')

        if test $type = aliases -a $found_non_alias -eq 1
            echo "Error: aliases must be defined before any other option or variable."
            return 1
        end

        switch $type
            case aliases
                set arguments (echo $arguments | yq e ".aliases += [\"$key\"]" -)
            case '*'
                if test $type != flags
                    set found_non_alias 1
                end

                set arguments (echo $arguments | yq e ".$type.$key = \"$value\"" -)
        end

    end

    # echo $arguments | yq -P '.' -
    echo $arguments
end

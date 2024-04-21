#!/usr/bin/fish

function print_header
    echo "Template Renderer Supporting Files, Streams, and Loops"
end

function read_template
    if test -p /dev/stdin
        cat -
    else if test -f $argv[1]
        cat $argv[1]
    else
        echo "Error: No valid input found." >&2
        exit 1
    end
end

function apply_filter
    set filter_type $argv[1]
    set variable_value $argv[2]
    set yaml_data $argv[3]

    switch $filter_type
        case upper
            echo $variable_value | tr '[:lower:]' '[:upper:]'
        case lower
            echo $variable_value | tr '[:upper:]' '[:lower:]'
        case each
            for item in (yq e ".$variable_value[]" $yaml_data)
                echo $item
            end
        case '*'
            echo $variable_value
    end
end

function process_template
    set yaml_data $argv[1]
    set output_content (cat)

    for placeholder in (echo $output_content | grep -o "{{\w+ \w+.*}}" | sort -u)
        set filter (string replace -r '({{|}})' '' $placeholder | cut -d' ' -f1)
        set variable_name (string replace -r '({{|}})' '' $placeholder | cut -d' ' -f2-)
        set variable_value (yq e ".$variable_name" $yaml_data)

        if test -n "$variable_value"
            set filtered_value (apply_filter $filter $variable_name $yaml_data)
            set output_content (echo $output_content | sed "s|$placeholder|$filtered_value|g")
        else
            echo "Warning: No value found for $variable_name" >&2
        end
    end

    echo $output_content
end

print_header
set yaml_data "data.yml"
read_template $argv[1] | process_template $yaml_data

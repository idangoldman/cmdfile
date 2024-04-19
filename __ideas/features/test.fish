#!/usr/bin/env fish

function process_block
    # Read from stdin
    while read -l line
        # Split the line into arguments based on '::' delimiter
        set -l args (string split "::" -- $line)
        set -l block_name $args[1]
        set -l description $args[2]
        set -l vars $args[3]
        set -l content (string replace -ra "\\n" "\n" -- $args[4]) # Revert escaped newlines to actual newlines

        # Do something with the arguments here
        echo "Block Name: $block_name"
        echo "Description: $description"
        echo "Variables: $vars"
        echo "Content: $content"
        echo ----------------
    end
end

gawk -f parser.awk general.bdd | process_block

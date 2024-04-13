function sources --description 'Source all files in the given list of arguments'
    set --local current_file (status --current-filename)

    for file in $argv
        if test "$file" != "$current_file" -a -r $file
            begin
                source $file
                echo "Sourced: $file"
                or echo "Failed to source: $file"
            end
        end
    end
end

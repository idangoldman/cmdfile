function find_project_root
    # Path to the file containing root indicators
    set indicator_file "/path/to/.root"

    # Read indicators from the file and escape them for use in regex
    set root_indicators (cat $indicator_file | string escape --style=regex)

    # Combine indicators into a single regex pattern
    set regex_pattern (string join "|" $root_indicators)

    # Start from the current directory
    set -l current_dir (pwd)

    while [ "$current_dir" != / ]
        # Use ls -a piped to grep to check for root indicators, including hidden files/folders
        if ls -a "$current_dir" | grep -qE "$regex_pattern"
            echo $current_dir
            return
        end

        # Move up one directory
        set current_dir (dirname $current_dir)
    end

    echo "Project root not found."
end

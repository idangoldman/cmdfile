function find_project_root
    set --local indicator_file .root
    set --local root_indicators (cat $indicator_file | string escape --style=regex)
    set --local regex_pattern (string join "|" $root_indicators)
    set --local current_dir $PWD

    while [ "$current_dir" != / ]
        if ls -a "$current_dir" | grep -qE "$regex_pattern"
            echo $current_dir
            return
        end

        set current_dir (dirname $current_dir)
    end

    echo "Project root not found."
end

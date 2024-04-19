function list
    set --local failed 0

    if test (count $argv) -eq 0
        ls "$tmp_base_dir"
    else
        for name in $argv
            set --local target "$tmp_base_dir/$name"
            if test -e "$target"
                ls "$target"
            else
                echo "No such file or directory: $name" >&2
                set failed 1
            end
        end
    end

    return $failed
end

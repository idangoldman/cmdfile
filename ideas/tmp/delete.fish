function delete
    set --local failed 0

    for name in $argv
        set target "$tmp_base_dir/$name"
        if not test -e "$target"
            echo "No such file or directory: $name" >&2
            set failed 1
            continue
        end

        if not rm -rvf "$target"
            echo "Failed to delete $name" >&2
            set failed 1
        end
    end

    return $failed
end

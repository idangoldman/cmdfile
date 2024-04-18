function create
    set --local failed 0

    for name in $argv
        set --local target (string trim -r "$name" /)
        if test "$name" = "$target/"
            set target (mktemp -d "$tmp_base_dir/$target.XXXXXX")
        else
            set target (mktemp "$tmp_base_dir/$target.XXXXXX")
        end

        if not test -n "$target"
            echo "Failed to create temp item: $name" >&2
            set failed 1
        else
            echo "$target"
        end
    end

    return $failed
end

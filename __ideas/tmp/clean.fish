function clean --on-event fish_exit
    if test -n "$tmp_base_dir" and test -e "$tmp_base_dir"
        if not rm -rvf "$tmp_base_dir"
            echo "Failed to clean temporary directory" >&2
            return 1
        end
    end

    set --erase tmp_base_dir
end

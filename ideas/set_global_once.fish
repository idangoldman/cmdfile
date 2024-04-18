function set_global_once
    if not set -q $global
        set --global $global $value
    end
end

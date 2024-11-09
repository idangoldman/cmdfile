function on_pwd_change --on-variable PWD
    switch_language_version "node ruby"

    if not contains -- (pwd -P) $PYTHONPATH
        set --global --export --append PYTHONPATH (pwd -P)
    end

    # if test -f $PWD/flake.lock
    #     nix develop --impure
    # end
end

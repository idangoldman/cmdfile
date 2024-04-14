function verify_repo --description 'Verify that the current directory is a GitHub repository'
    # if not test -d .git
    #     echo "Not a git repository"
    #     return 1
    # end

    set --local remote (git remote -v | awk '{print $2}' | head -n 1)

    if not string match --quiet --ignore-case --regex 'github\.com' $remote
        echo "Not a GitHub repository"; and return 1
    end

    # echo repository owner and name
    string match --regex --ignore-case --groups-only 'github\.com\:(.+)\.git$' $remote; and return 0
end

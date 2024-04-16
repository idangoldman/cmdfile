function verify_repo --description 'Verify that the current directory is a GitHub repository'
    set --local repo_folder (find_location_of .git $PWD)

    if not test -d $repo_folder
        echo "Not a Git repository"; and return 1
    end

    set --local remote (git --git-dir $repo_folder remote -v | awk '{print $2}' | head -n 1)

    if not string match --quiet --ignore-case --regex 'github\.com' $remote
        echo "Not a GitHub repository"; and return 1
    end

    # echo repository owner and name
    string match --regex --ignore-case --groups-only 'github\.com\:(.+)\.git$' $remote; and return 0; or return 1
end

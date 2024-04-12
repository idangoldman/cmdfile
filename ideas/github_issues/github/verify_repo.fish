function github_verify_repo --description 'Verify that the current directory is a GitHub repository'
    if not test --directory .git
        echo "Not a git repository"
        return 1
    end

    set --local host github.com
    set --local remote (git remote -v | awk '{print $2}' | head -n 1)

    if not string match --ignore-case --regexp $host $remote
        echo "Not a GitHub repository"
        return 1
    end

    # echo repository owner and name
    string match --regex --ignore-case --groups-only '$host[:/](.*)[.]git' $remote
end

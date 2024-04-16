function main --argument-names action
    dependencies gh jq yq
    sources .

    set --local repo (verify_repo)
    set --local folder (exists_or_create folder .github/issues)

    switch $action
        case close reopen
            # push_issues
        case update
            # update_issues
        case pull
            pull_issues
        case '*'
            echo "Invalid action: $action"
            return 1
    end
end

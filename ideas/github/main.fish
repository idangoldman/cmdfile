function main --argument-names action
    dependencies gh jq yq
    sources

    set --local repo (verify_repo)
    set --local folder (exists_or_create folder .github/issues)

    log_message INFO "$repo $folder"

    # switch $action
    #     case close reopen
    #         # push_state $action $repo $folder
    #     case update
    #         # update_issues $repo $folder
    #     case pull
    #         pull_issues $repo $folder
    #     case '*'
    #         echo "Invalid action: $action"
    #         return 1
    # end
end

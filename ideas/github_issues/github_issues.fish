function github_issues --argument-names action
    set --local repo github_verify_repo
    or exit

    set --local folder .github/issues
    exists_or_create folder $folder

    switch $action
        case close create delete reopen
            # github_push_issue $action $repo $folder
        case update
            # github_update_issues $repo $folder
        case pull
            # github_pull_issues $repo $folder
        case '*'
            echo "Invalid action: $action"
            return 1
    end

    for md_file in $folder/**/*.md
        set --local yaml_file (md_to_yaml $md_file)
        set --local issue_number (yq e '.number // 0' $yaml_file)
        set --local issue_state (yq e '.state // "open"' $yaml_file)

        switch $action
            case reopen close delete
                if test $issue_state = $action
                    gh issue $action $issue_number --repo $repo
                end
            case create
                # github_push_issue $yaml_file
            case update
                set --local md_create_time (date -r $md_file +%s)
                set --local gh_update_time (gh issue view $issue_number --repo $repo --json updatedAt | jq -r '.updatedAt' | xargs date -d +%s)

                if test $md_create_time -gt $gh_update_time
                    # github_push_issue $yaml_file
                    # gh issue edit $issue_number --repo $repo --file $md_file
                else
                    # fetch the issue and update the md file
                    # github_pull_issue
                end
            case '*'
                echo "Invalid action: $action"
                return 1
        end
    end
end

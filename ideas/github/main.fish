function main --argument-names action
    set --local repo github_verify_repo
    or return 1

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


function gh_issue_action -a action issue_data
    switch $action
        case create
            set new_issue (echo $issue_data | jq -r '"--title \"" + .title + "\" --body \"" + .body + "\" --label \"" + .labels + "\" --assignee \"" + .assignees + "\""' | gh issue create -R $repo -F -)
            echo $new_issue | string match -r '^[^#]*#([0-9]+)'
        case update
            echo $issue_data | jq -r '"gh issue edit \(.number) --title \"" + .title + "\" --body \"" + .body + "\" --label \"" + .labels + "\" --assignee \"" + .assignees + "\""' | source
        case close
            gh issue close (echo $issue_data | jq -r '.number') -R $repo
    end
end

function process_issues -a action
    set --local github_issues_dir .github/issues
    if not test -d $github_issues_dir
        echo "Directory does not exist: $github_issues_dir"
        return 1
    end

    for file in (ls $folder/*.md)
        set yaml_path (md_to_yaml $file)
        set issue_data (yq e '.' $yaml_path)

        switch $action
            case create
                if test (yq e '.number' $yaml_path) -eq 0
                    set new_issue_number (gh_issue_action $action $issue_data)
                    if set -q new_issue_number[1]
                        mv $file (string replace -r '(.md)$' "-$repo-$new_issue_number\1" $file)
                        echo "Created and updated file name for issue: $new_issue_number"
                    end
                end
            case update
                set file_mod_time (date -r $file +%s)
                set issue_update_time (gh issue view (echo $issue_data | jq -r '.number') -R $repo --json updatedAt | jq -r '.updatedAt' | xargs date -d +%s)
                if [ $file_mod_time -gt $issue_update_time ]
                    gh_issue_action $action $issue_data
                    echo "Updated issue from file: $file"
                end
            case close
                if echo $issue_data | jq -e '.status == "closed"'
                    gh_issue_action $action $issue_data
                    echo "Closed issue as per the status in the file: $file"
                end
        end
    end
end

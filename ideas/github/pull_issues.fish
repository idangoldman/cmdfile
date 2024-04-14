function pull_issues --argument-names repo folder
    set --local issues (gh issue list --repo $repo --json number,title --jq '.[] | "\(.number)\t\(.title)"')

    for issue in $issues
        set issue_number (echo $issue | cut -f1)
        set issue_title (echo $issue | cut -f2- | string replace -a '/' '_')

        set issue_data (pull_issue $issue_number)

        set filename "$folder/$issue_title.md"
        echo $issue_data >$filename
        echo "Downloaded issue #$issue_number $issue_title to $filename"
    end
end

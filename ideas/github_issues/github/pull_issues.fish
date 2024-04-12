function pull_github_issues
    verify_github_repo
    or exit

    set --local folder exists_or_create --folder .github/issues

    for issue in list_github_issues
        set issue_number (echo $issue | cut -f1)
        set issue_title (echo $issue | cut -f2- | string replace -a '/' '_')

        set issue_data (pull_github_issue $issue_number)

        set filename "$folder/$issue_title.md"
        echo $issue_data >$filename
        echo "Downloaded issue #$issue_number $issue_title to $filename"
    end
end

function github_list_issues
    gh issue list --json number,title --jq '.[] | "\(.number)\t\(.title)"'
end

function pull_issue --argument-names issue_number
    set --local issue_data (gh issue view $issue_number --json number,title,state,createdAt,updatedAt,body,labels,assignees)

    echo (echo $issue_data | yq e '
        "---\n",
        "number: \( .number )",
        "title: \( .title )",
        "state: \( .state )",
        "created_at: \( .createdAt )",
        "updated_at: \( .updatedAt )",
        "labels:",
        (.labels | map(.name) | .[] | "- \(. )"),
        "assignees:",
        (.assignees | map(.login) | .[] | "- \(. )"),
        "---\n\n",
        "\( .body )\n"
    ' -)
end

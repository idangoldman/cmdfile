set --global md_to_yaml_tmp_dir (mktemp -d)

function md_to_yaml --description 'Parse frontmatter and body text from a markdown file' --argument-names input
    set --local output (path change-extension yaml (basename $input))

    gawk -f md_to_yaml.awk $input >$md_to_yaml_tmp_dir/$output

    echo $md_to_yaml_tmp_dir/$output
end

function md_to_yaml_cleanup
    rm -rvf $md_to_yaml_tmp_dir
    set --erase md_to_yaml_tmp_dir
end

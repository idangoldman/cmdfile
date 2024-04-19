# FNM has a good take on how to deal and switch between versions in thier `fnm help` command

function switch_language_version --argument-names languages
    dependencies cat yq fnm rbenv

    set languages (string split ' ' (string lower $languages))
    set --local version_regex '([0-9]+(?:[\.-][0-9a-z]+)*)'

    for language in $languages
        set --local current_version
        set --local version_files (yq '.version_files.'$language'[]' "$CMDFILE_CONFD_PATH/_index.yml")

        for file in $version_files
            if test -r $PWD/$file
                set current_version (cat $PWD/$file | string match --regex --groups-only --ignore-case $version_regex)
                test (count $current_version) -gt 0; and break
            end
        end

        if test (count $current_version) -gt 0
            echo "$language v$current_version"

            switch $language
                case node
                    fnm use $current_version --silent-if-unchanged
                case ruby
                    rbenv shell $current_version
                    # rbenv local $current_version
            end
        end
    end
end

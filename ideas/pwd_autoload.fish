function pwd_autoload --on-variable PWD
    # Node version management
    set node_version_file (begin; test -f .nvmrc; and echo .nvmrc; or test -f node-version; and echo node-version; end)
    if test -n "$node_version_file"
        set node_version (cat $node_version_file)
    else if test -f package.json
        set node_version (yq e '.engines.node' package.json)
    end

    if test -n "$node_version"
        fnm use $node_version --silent-if-unchanged
    end

    # Ruby version management
    if test -f Gemfile
        set ruby_version (grep -oP "ruby '\K[^\']+" Gemfile)
        if type -q rbenv
            rbenv shell $ruby_version
        else if type -q rvm
            rvm use $ruby_version
        end
    end
end

function node_autoload --on-variable PWD --description 'Change Node version on directory change'
    status --is-command-substitution; and return
    if test -f .node-version -o -f .nvmrc
        fnm use --silent-if-unchanged
    end
end

function fnm_completions --description 'Generate completions for fnm'
    fnm completions --shell fish
end

function node_update_version_file --description 'Update Node version'
    node --version >.node-version
end

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

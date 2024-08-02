function dotlinks_up --argument-names target source force
    if test --exists $target; and not test "$force" = true
        echo "Skipping existing: $target"
        return 0
    end

    set --local target_dir (dirname $target)
    mkdir --parents --verbose $target_dir
    ln --symbolic --force --verbose $source $target
end

function dotlinks_down --argument-names target
    if not test -L $target
        echo "Skipping non-link: $target"
        return 0
    end

    unlink --verbose $target
end

function dotlinks --description 'Manage dotfiles links'
    set --local dotlinks_yml $DOTFILES_PATH/configs/dotlinks.yml

    argparse force --description 'Force overwrite existing links' -- $argv
    argparse up --description 'Symlink all links in the dotlinks.yml file' -- $argv
    argparse down --description 'Remove all links in the dotlinks.yml file' -- $argv
    argparse file --description 'Specify a different dotlinks.yml file' -- $argv
    argparse --min-args=1 -- $argv

    if test "$file"
        set dotlinks_yml $file
    end

    if not test -f $dotlinks_yml
        echo "Error: $dotlinks_yml not found"
        return 1
    end

    if test "$up" = true
        echo "Linking files..."
        for key in (yq e "keys | .[]" $dotlinks_yml)
            set target $key
            set source (yq e ".\"$key\"" $dotlinks_yml)
            dotlinks_up $target $source
        end
    else if test "$down" = true
        echo "Cleaning up links..."
        for key in (yq e "keys | .[]" $dotlinks_yml)
            set target $key
            dotlinks_down $target
        end
    else
        echo "Usage: dotlinks [--up | --down] [--force] [--file <file>]"
        return 1
    end
end

# Dotsym.yml file example:

# Brew
# ~/.config/Brewfile: configs/Brewfile

# Git
# ~/.config/git/.gitattributes: configs/git/.gitattributes
# ~/.config/git/config: configs/git/.gitconfig
# ~/.config/git/.gitignore: configs/git/.gitignore

# Fish
# ~/.config/fish/completions: configs/fish/completions
# ~/.config/fish/conf.d: configs/fish/conf.d
# ~/.config/fish/config.fish: configs/fish/config.fish
# ~/.config/fish/functions: configs/fish/functions
# ~/.config/fish/plugins: configs/fish/plugins

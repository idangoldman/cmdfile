# CMD - Command Line Tool [WIP]

[A Cool GIF]()

Opinionated way to manage command line aliases using a config file.

## Features
- [ ] **[YAML|JSON|TOML]** config files
- [ ] **Nested** configurations
- [ ] **Sudo** permissions
- [ ] **VARIABLES**
- [ ] **Environment**
- [ ] **Context**, folder specific command execution
- [ ] **Logs**
- [ ] **OS** specific commands
- [ ] **Cron**
- [ ] **Remote** execution of commands
- [ ] **Package**, universal mapping for your project's package manager
- [ ] **Autocomplete**
- [ ] **Style and Testing**, tested codebase and same writing style across the codebase.

## Examples

## Table of Content
## Background

## Development
```
brew install pipenv pyenv && pyenv install 3.10.3 && pipenv install --dev && pipenv run ./bin/install

pipenv run black src tests bin/cmd
pipenv run pylint src tests bin/cmd
```
### Installment
```
git clone git@github.com:123code-il/cmd.git && ./cmd/bin/install
#brew install cmd_line
```
### Structure

## Commands and Flags

```
cmd [command] [action] [VARIABLES] [--flags]

# Commands
add [name]
clean
help --help
install [name]
uninstall [name]
update [name]

# Flags
--dry # show command
--env
--extend
--global
--list
--os
--package
--path
--sudo
--verbos

--remote
--netrc
--sshrc
```

## Configuration Files
```
{~/,./}cmd.{yml, json}
~/{.,_}netrc # _netrc on windows
~/.ssh/config
```

## License
```
# init one?
python -m pip install .
https://docs.python.org/3/distutils/introduction.html
https://pip.pypa.io/en/stable/reference/build-system/pyproject-toml/
https://setuptools.pypa.io/en/latest/userguide/pyproject_config.html
https://setuptools.pypa.io/en/latest/setuptools.html
https://stackoverflow.com/questions/59997065/pip-python-normal-site-packages-is-not-writeable
```

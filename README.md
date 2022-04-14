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
- [ ] **Style and Testing**, tested code base and same writing style across the code base.

## Examples

## Table of Content
## Background

## Development

### Installment
```
git clone git@github.com:123code-il/cmd.git && ./cmd/bin/install
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

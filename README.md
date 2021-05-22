# CMD - Command Line Tool [WIP]

[A Cool GIF]()

Modern way to manage command line aliases using config file.

## Features
- [ ] **[YAML|JSON|TOML]** config files
- [ ] **Nested** configurations
- [ ] **Sudo**
- [ ] **VARIABLES**
- [ ] **Context**, folder specific command execution
- [ ] **OS** specific commands
- [ ] **Remote**
- [ ] **Package**
- [ ] **Autocomple**

## Examples

## Table of Content
## Background

## Development

## Install for Development only
```
git clone git@github.com:123code-il/cmd.git && ./cmd/bin/install
```

### Commands and Flags

```
cmd [command] [action] [PARAMETER] [--flag]

# Commands
add [name]
remove [name]
help --help
install [name]
update [name]
clean

# Flags
--extend
--list
--package
--path
--sudo
--os
--dry # show command
--env

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

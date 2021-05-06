# CMD - Command Line Tool [WIP]

[A Cool GIF]()

Modern way to manage command line aliases using config file.

## Features
- [] **[YAML|JSON|TOML]** config files
- [] **Sudo**
- [] **Variables**
- [] **Nested** configurations
- [] **Context**, folder specific command execution
- [] **OS** specific commands
- [] **Remote**
- [] **Package**
- [] **Autocomple**

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
cmd [command] [action] [-variable] [--flag]

# Commangs
add [name]
delete [name]
help --help
init [name]
install [name]

# Flags
--extend
--list
--package
--path
--sudo
--output
--os
--show-command (dry?)

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

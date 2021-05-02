# CMD - Command Line Tool [WIP]
Modern way to manage command line aliases using config file.

```
cmd [command] [action] [-variable] [--flag]
```

```
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

## Install for Development only
```
git clone git@github.com:123code-il/cmd.git && ./cmd/bin/install
```

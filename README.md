# CMD - Command Line Tool [WIP]

**Opinionated way to manage command line aliases using a config file**

```bash
cmd <commands...> [args...] [option=] [--flag]
```

## TL;DR

| Parameter | Description | Alias | Command |
| - | - | - | - |
| cmd | Base command for running aliases | `cmd restart`| `shutdown -r now` |
| commands | Trail of nested aliases, last command found is executed | `cmd lanip`| `ipconfig getifaddr en0` |
| args | Array of values seperated by a space | `cmd find filename.pdf` | `find ./ -iname {{ $0 }}` |
| option | `key=value` pair, `key` assigned in the alias and `value` replaced with the in the command | `cmd git commit="message"` | `git add . && git commit={{ commit }}` |
| --flag | `boolean` or `key=value` pair, built-in enhancement helpers | `cmd xcode reset --sudo`, `cmd docker up --path=~/project-x` | `sudo xcode-select --reset`, `cd ~/project-x && docker compose up -d` |

## Features to-do list

- [ ] **[YAML|JSON]** config files
- [ ] **Autocomplete**
- [ ] **Context**, folder specific command execution
- [ ] **Cron**
- [ ] **Environment**
- [ ] **Logs**
- [ ] **Nested** aliases
- [ ] **Nested** configurations
- [ ] **OS** specific commands
- [ ] **Package**, universal mapping for your project's package manager
- [ ] **Remote** execution of commands
- [ ] **Style and Testing**, tested codebase and same writing style across the codebase.
- [ ] **Sudo** permissions
- [ ] **Options**

## Commands and Flags

```bash
--cmdfile
--dry # show command
--path
--sudo
--env, -e
help, --help, -h
--version, -v
```

## Configuration Files

```bash
{~/,./}cmd.{yml,yaml,json}
```

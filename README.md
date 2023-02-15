# CMD - Command Line Tool [WIP]

**Opinionated way to manage command line aliases using a config file**

```shell
cmd <aliases...> [args...] [option=] [--flag]
```

## TL;DR

| Parameter | Description                                                                                | Use Example                                                        | Executed Command                                                               |
| --------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------ | --------------------------------------------------------------------- |
| cmd       | Base command for running aliases                                                           | `cmd restart`                                                  | `shutdown -r now`                                                       |
| aliases   | Trail of nested aliases, last alias found is executed                                    | `cmd lanip`                                                    | `ipconfig getifaddr en0`                                                |
| args      | Array of values separated by a space                                                       | `cmd find filename.pdf`                                        | `find ./ -iname $0`                                               |
| option    | `key=value` pair, `key` assigned in the alias and `value` replaced with the in the command | `cmd git commit="message"`                                           | `git add . && git commit=$COMMIT`                                  |
| --flag    | `boolean` or `key=value` pair, built-in enhancement helpers                                | `cmd xcode reset --sudo`, `cmd docker up --path=~/project-x`         | `sudo xcode-select --reset`, `cd ~/project-x && docker compose up -d`     |

## Installment

```shell
# NPM
npm install --global cmdfile

# PNPM
pnpm add --global cmdfile

# YARN
yarn global add cmdfile
```

## Configuration Files

```yml
# variations of config file types
# {~/,./}cmd.{yml,yaml,json}

# simple config file - suitable for project folders
dev: "npm run dev"
clean: "rm -fr node_modules package-lock.json"
install: "npm install"
reinstall:
  - "cmd clean"
  - "cmd install"
```

## Flags

```shell
--cmdfile, -c
--envfile, -e
--help, -h
--info, -i
--path, -p
--sudo, -s
--version, -v
```

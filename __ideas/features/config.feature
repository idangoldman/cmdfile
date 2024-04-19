Feature
  Ability of the program to load a config file in `YAML`, `JSON`, and `TOML` formats into a config dict object.

Background
  Given A user typed a command and an action
    And Config filename should always be `cmd`

Scenario Default
  When The program loads default config file
  Then `PACKAGE_PATH/cmd.yml` file loaded into a config dict

Scenario Home
  When The program loads user's home folder config file
  Then `HOME_PATH/cmd.toml` file loaded and merged into a `config dict`
  But After config dict was already populated Default files configurations

Scenario Pwd
  When The program loads current folder's config file
  Then `PWD_PATH/cmd.json` file loaded and merged into a `config dict`
  But After `config dict` was already populated with Home and Default files configurations

Scenario None
  When The program loads current folder's config file
  But The config file not to be found
  Then `config dict` remain populated with Home and Default configurations


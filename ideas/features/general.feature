Feature: General use of `cmd`

  As a developer I want an easy way to manage and execute command line workflows without the need to remember long piped commands nor typing keyword clues into ctrl+r.

Background:
  Given `cmd` command exists

Scenario: Prompt of help document
  When developer types `cmd --help` into the console
  Then the contents of the help file would be prompt

Scenario: Prompt cmdfile version
  When developer types `cmd -v` into the console
  Then he would be prompt with the current version of cmd

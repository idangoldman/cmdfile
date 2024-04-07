Feature: General use of `cmd`

Background:
  As a developer I want an easy way to manage and execute command line workflows without the need to remember long piped commands nor typing keyword clues into ctrl+r.

  Given `cmd` command exists

Scenario: Prompt of help document
  When developer types `cmd --help` into the console
  Then the contents of "$CMDFILE_USER_DIR/help.txt" file would be prompt

Scenario: Prompt cmdfile version
  When developer types `cmd -v` into the console
  Then he would be prompt with "$CMDFILE_VERSION" version

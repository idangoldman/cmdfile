Background:
  Given a command cmd
    And the command cmd has the following help text:
    """
    cmd --help
    """

Feature: Command Line Interface
  Scenario: Execute cmd with no aliases, options, or flags
    Given a command cmd
    When we run "cmd"
    Then the output should include "Expected output for no aliases, options, or flags"

  Scenario: Execute cmd with an alias and no options or flags
    Given a command cmd with an alias "alias1"
    When we run "cmd alias1"
    Then the output should include "Expected output for alias1 with no options or flags"

  Scenario: Execute cmd with an alias and an option
    Given a command cmd with an alias "alias1"
      And an option "option=value"
    When we run "cmd alias1 option=value"
    Then the output should include "Expected output for alias1 with option=value"

  Scenario: Execute cmd with multiple aliases and a flag
    Given a command cmd with aliases "alias1 alias2"
      And a flag "--flag=true"
    When we run "cmd alias1 alias2 --flag=true"
    Then the output should include "Expected output for alias1 alias2 with flag=true"

  Scenario: Execute cmd with an argument and no options or flags
    Given a command cmd with an argument "argumentValue"
    When we run "cmd argumentValue"
    Then the output should include "Expected output for argumentValue"

  Scenario: Execute cmd with no aliases but with an option and a flag
    Given a command cmd
      And an option "option=value"
      And a flag "--flag=false"
    When we run "cmd option=value --flag=false"
    Then the output should include "Expected output for option=value with flag=false"

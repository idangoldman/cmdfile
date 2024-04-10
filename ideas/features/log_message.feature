Feature: Enhanced Logging

  The log_msg command allows users to log messages with varying severity levels to a log file. Users can view help information, log messages in verbose mode, and ensure messages are correctly formatted and saved.

  Background:
    Given the logging utility is available
    And a log.txt and help.txt file exist in the correct directories

  Scenario: Display help information with -h flag
    When the user runs "log_msg -h"
    Then the content of help.txt should be displayed
    And the program exits with a status code of 0

  Scenario: Log a message with default info level
    Given no explicit level is provided
    When the user logs a message "Test message"
    Then the message "[<current_timestamp>][INFO] Test message" should be added to the log file

  Scenario: Log a message with a specified level
    When the user logs a message "Test warning" with level "warning"
    Then the message "[<current_timestamp>][WARNING] Test warning" should be added to the log file

  Scenario: Log a message in verbose mode
    Given the verbose mode is enabled
    When the user logs a message "Verbose test" with level "debug"
    Then the message "[<current_timestamp>][DEBUG] Verbose test" should be added to the log file
    And the message is also printed to the console

  Scenario: Attempt to log a message with incorrect arguments
    When the user attempts to log a message with more than two arguments
    Then the message "Incorrect number of arguments.\n\n" and the content of help.txt should be displayed
    And the program exits with a status code of 1

  Scenario: Log a message with the verbose flag but without verbose messages
    Given the verbose mode is enabled
    When the user logs a message "Simple test" without the verbose flag
    Then the message "[<current_timestamp>][INFO] Simple test" should be added to the log file
    And no message is printed to the console

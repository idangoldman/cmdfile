#!/usr/bin/env fish

sources "functions/parser"

# PARSE ARG EXAMPLE TESTS
parse_arg --flag1=value1
parse_arg --flag2
parse_arg action1
parse_arg action2
parse_arg option2=value2
parse_arg VAR1=value3
parse_arg -h
parse_arg -v=1.2.3

# PARSE ARGS EXAMPLE TESTS
parse_args --sudo code editor=vim COLOR=blue --cwd=~/Documents
parse_args option=true before --action
parse_args -h -v=1.2.3

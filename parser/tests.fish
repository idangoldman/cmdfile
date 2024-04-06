#!/usr/bin/env fish

source parse_args.fish
source parse_arg.fish

# PARSE ARG EXAMPLE TESTS
cmdfile_parse_arg --flag1=value1
cmdfile_parse_arg --flag2
cmdfile_parse_arg action1
cmdfile_parse_arg action2
cmdfile_parse_arg option2=value2
cmdfile_parse_arg VAR1=value3

# PARSE ARGS EXAMPLE TESTS
cmdfile_parse_args --sudo code editor=vim COLOR=blue --cwd=~/Documents
cmdfile_parse_args option=true before --action

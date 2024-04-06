#!/usr/bin/env fish

for file in ./parse_*.fish
    echo "Loading $file"
    source $file
end

# PARSE ARG EXAMPLE TESTS
cmdfile_parse_arg --flag1=value1
cmdfile_parse_arg --flag2
cmdfile_parse_arg action1
cmdfile_parse_arg action2
cmdfile_parse_arg option2=value2
cmdfile_parse_arg VAR1=value3
cmdfile_parse_arg -h
cmdfile_parse_arg -v=1.2.3

# PARSE ARGS EXAMPLE TESTS
cmdfile_parse_args --sudo code editor=vim COLOR=blue --cwd=~/Documents
cmdfile_parse_args option=true before --action
cmdfile_parse_args -h -v=1.2.3

function log_message
    set --local help_file_path "$CMDFILE_MANUALS_PATH/log_message.txt"
    set --local caller_basename (basename (status stack-trace | awk '/file/ {file=$NF} END {print file}'))
    set --local log_file_path $PWD/$caller_basename.log

    argparse v/verbose h/help -- $argv
    or begin
        cat $help_file_path
        return 1
    end

    if set --query _flag_help
        cat $help_file_path
        return 0
    end

    #( none error warning info debug )
    set --local level info
    set --local message

    switch (count $argv)
        case 1
            set message $argv[1]
        case 2
            set level $argv[1]
            set message $argv[2]
        case '*'
            echo "Incorrect number of arguments.\n\n"
            cat $help_file_path
            return 1
    end

    set level (string upper $level)
    set --local timestamp (date "+%Y-%m-%d %H:%M:%S")
    set --local verbose_mode 0
    set --local formatted_message "[$timestamp][$level] $message"

    echo $formatted_message >>$log_file_path

    if set --query _flag_verbose
        set verbose_mode 1
    end

    if test $verbose_mode -eq 1
        echo $formatted_message
    end

    return 0
end

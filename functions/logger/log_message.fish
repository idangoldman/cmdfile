alias log_msg "log_message $argv"

function log_message
  set --local help_file_path (realpath (dirname (status --current-filename))/help.txt)
  set --local log_file_path  (pwd -P)/log.txt

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

  set --local timestamp (date "+%Y-%m-%d %H:%M:%S")
  set level (string upper $level)
  set --local formatted_message "[$timestamp][$level] $message"
  echo $formatted_message >> $log_file_path

  set --local verbose_mode 0
  if set --query _flag_verbose
    set verbose_mode 1
  end
  if test $verbose_mode -eq 1
      echo $formatted_message
  end
end

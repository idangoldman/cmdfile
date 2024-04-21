alias cmd cmdfile
alias log_msg log_message

function cmdfile_dotbot
    command dotbot --exit-on-failure --force-color --verbose --base-directory=$CMDFILE_PATH --config-file=$CMDFILE_PATH/dotbot.yml
end

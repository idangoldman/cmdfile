function cmdfile_setup
    cmdfile_check_for_dependencies

    set -gx CMDFILE_CONFIG_NAME "cmd.yml"
    set -gx CMDFILE_CONFIG_NAMES "cmd.yml" "cmdfile.yml" "cmd.yaml" "cmdfile.yaml"
    set -gx CMDFILE_VERSION "0.0.1"
    set -gx CMDFILE_USER_DIR (cmdfile_config_user_dir)
    set -gx CMDFILE_CONFIG_PATH (cmdfile_config_find)
end

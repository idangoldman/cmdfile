function cmdfile_setup
    dependencies yq gzip cat grep gawk

    set --global --export CMDFILE_CONFIG_NAME "cmd.yml"
    set --global --export CMDFILE_CONFIG_NAMES "cmd.yml" "cmdfile.yml" "cmd.yaml" "cmdfile.yaml"
    set --global --export CMDFILE_VERSION "0.0.1"
    set --global --export CMDFILE_USER_DIR (cmdfile_config_user_dir)
    set --global --export CMDFILE_CONFIG_PATH (cmdfile_config_find)
end

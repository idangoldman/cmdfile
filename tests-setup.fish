#!/usr/bin/env fish

source setup.fish
echo "SETUP => Loaded"

# cmdfile_check_for_dependencies
# cmdfile_config_user_dir
cmdfile_setup

# cmdfile_config_find
echo $CMDFILE_CONFIG_NAME
echo $CMDFILE_CONFIG_NAMES
echo $CMDFILE_VERSION
echo $CMDFILE_USER_DIR
echo $CMDFILE_CONFIG_PATH

#!/usr/bin/env fish

source setup.fish
echo "SETUP => Loaded"

# cmdfile_check_for_dependencies
# cmdfile_config_dir
cmdfile_setup

echo $CMDFILE_CONFIG_NAME
echo $CMDFILE_CONFIG_NAMES
echo $CMDFILE_VERSION
echo $CMDFILE_USER_DIR

#!/usr/bin/env fish

sources "$CMDFILE_PATH/__ideas/cmdfile"
echo "SETUP => Loaded"

# dependencies yq gzip cat grep gawk
# cmdfile_config_user_dir
cmdfile_setup

# cmdfile_config_find
echo $CMDFILE_CONFIG_NAME
echo $CMDFILE_CONFIG_NAMES
echo $CMDFILE_VERSION
echo $CMDFILE_USER_DIR
echo $CMDFILE_CONFIG_PATH

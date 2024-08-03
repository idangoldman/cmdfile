set --global --export CMDFILE_PATH             (dirname (dirname (realpath (status --current-filename))))
set --global --export CMDFILE_COMPLETIONS_PATH "$CMDFILE_PATH/completions"
set --global --export CMDFILE_CONFD_PATH       "$CMDFILE_PATH/conf.d"
set --global --export CMDFILE_FUNCTIONS_PATH   "$CMDFILE_PATH/functions"
set --global --export CMDFILE_IDEAS_PATH       "$CMDFILE_PATH/__ideas"
set --global --export CMDFILE_MANUALS_PATH     "$CMDFILE_PATH/manuals"
set --global --export CMDFILE_THEMES_PATH      "$CMDFILE_PATH/themes"

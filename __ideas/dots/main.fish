#!/usr/bin/env fish

echo "Starting dotfile setup..."

setup_environment
create_directories
link_files
execute_scripts
clean_files

echo "Dotfile setup complete. To restore backups, run 'restore_backup'"

function rotate_logs
  set -l logdir (dirname $LOGFILE)
  set -l backup_prefix /path/to/your/logfile
  set -l max_size (math 5*1024*1024) # 5MB in bytes

  if test (stat -f %z $LOGFILE) -gt $max_size
    set -l timestamp (date "+%Y-%m-%d-%H%M%S")
    set -l backup "$backup_prefix-$timestamp.log"
    mv $LOGFILE $backup
    touch $LOGFILE
    gzip $backup

    set -l old_backups (find $logdir -type f -name "logfile-*.log.gz" | sort -r | tail -n +4)
    if test (count $old_backups) -gt 0
      echo "Removing old backup files:"
      for file in $old_backups
        rm $file
      end
    end
  end
end

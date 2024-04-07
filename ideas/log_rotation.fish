function rotate_logs
  set --local logdir (dirname $LOGFILE)
  set --local backup_prefix /path/to/your/logfile
  set --local max_size (math 5*1024*1024) # 5MB in bytes

  if test (stat -f %z $LOGFILE) -gt $max_size
    set --local timestamp (date "+%Y-%m-%d-%H%M%S")
    set --local backup "$backup_prefix-$timestamp.log"
    mv $LOGFILE $backup
    touch $LOGFILE
    gzip $backup

    set --local old_backups (find $logdir -type f -name "logfile-*.log.gz" | sort -r | tail -n +4)
    if test (count $old_backups) -gt 0
      echo "Removing old backup files:"
      for file in $old_backups
        rm $file
      end
    end
  end
end

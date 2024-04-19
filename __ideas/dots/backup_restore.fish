function backup_restore
    for file in (find ~/ -name "*.dot.bak")
        set original_file (string replace -r '_[0-9]{4}-[0-9]{2}-[0-9]{2}_[0-9]{2}-[0-9]{2}-[0-9]{2}.dot.bak$' '' $file)
        echo "Restoring backup from $file to $original_file"
        if not $dry_run
            if test -e $original_file
                rm $original_file
            end
            mv $file $original_file
        end
    end
end

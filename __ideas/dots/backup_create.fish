function backup_create
    set file $argv[1]
    set timestamp (date "+%Y-%m-%d_%H-%M-%S")
    set backup_file $file"_"$timestamp".dot.bak"
    if test -e $file -a ! test -L $file
        echo "Backing up $file to $backup_file"
        mv $file $backup_file
    end
end

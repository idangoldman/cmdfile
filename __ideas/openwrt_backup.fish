function openwrt_backup \
    --argument-names operation command_after_completion \
    --description "Backup and restore OpenWRT configuration"

    set --local remote_path /etc/
    set --local local_path $DOTFILES_FOLDER/backups/openwrt/
    set --local rsync_options --checksum --archive --copy-links --compress --human-readable --progress --stats --verbose

    switch $operation
        case push
            # set --local include_paths '--include="*/"'
            set --local include_paths '--include="haproxy.cfg"'
            # set --append include_paths '--include="config/acme"'
            set --append include_paths '--include="config/dhcp"'
            set --append include_paths '--exclude="*"'

            set rsync_direction $include_paths $local_path home:$remote_path
        case pull
            set rsync_direction home:$remote_path $local_path

            set --append rsync_options --delete-delay
        case '*'
            echo "Invalid operation: $operation"
            echo "Usage: openwrt_backup [push|pull]"
            exit 1
    end

    # echo $rsync_direction
    # echo ""
    # echo $rsync_options
    # echo "rsync $rsync_options $rsync_direction"

    rsync $rsync_options $rsync_direction

    if test $status -eq 0
        if test -n "$command_after_completion"
            eval $command_after_completion
        end
    end

    echo Done
end

function openwrt_backup_archive \
    --description "Create a tar.gz archive of the OpenWRT configuration"

    set --local date_stamp (date "+%Y%m%d_%H%M%S")
    set --local archive_from $DOTFILES_FOLDER/backups/openwrt
    set --local archive_to $DOTFILES_FOLDER/backups/openwrt_backup_$date_stamp.tar.gz.backup
    gtar --create --gzip --verbose --file=$archive_to --directory=$archive_from .
end

function openwrt_reload_haproxy
    ssh home "haproxy -f /etc/haproxy.cfg -c"
    if test $status -eq 0
        ssh home "/etc/init.d/haproxy reload"
        ssh home "/etc/init.d/dnsmasq restart"
    end
end

function openwrt_reload_acme
    ssh home "/etc/init.d/acme restart"
end

openwrt_backup pull
# openwrt_backup push
# openwrt_backup_archive
# openwrt_backup push openwrt_reload_acme
# openwrt_backup push openwrt_reload_haproxy

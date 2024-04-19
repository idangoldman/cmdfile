# recursive_command '*.txt' 'chmod 600'
# recursive_command '*.md' 'pandoc -o {.}.html'
# recursive_command '*.png' 'optipng -o7'
# recursive_command '*.txt' 'echo "Added via script" >>'
# recursive_command '*.bmp' 'convert {} {.}.jpg'
# recursive_command '*.log' '[ $(stat -c %s {}) -gt 1048576 ] && rm {}'
# recursive_command '*.mp3' 'stat -c %s {} >> sizes.txt'

function recursive_command
    if count $argv != 2
        echo "Usage: recursive_command 'pattern' 'command'"
        return 1
    end

    set -l pattern $argv[1]
    set -l command $argv[2]
    set -l start_dir (dirname $pattern)

    if not string match -q / (string sub -l 1 -- $start_dir)
        set start_dir $PWD/$start_dir
    end

    set start_dir (realpath $start_dir)
    set pattern (basename $pattern)

    find $start_dir -type f -name "$pattern" -print0 | while read -z file
        if not eval "$command" "$file"
            echo "Failed to execute on $file"
            continue
        end

        echo "Executed on $file"
    end
end

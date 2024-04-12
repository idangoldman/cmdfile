#!/usr/bin/env fish

function convert_image -d "Convert image to AVIF and WebP formats"
    set -l file $argv[1]
    set -l quality $argv[2]

    if not test -f $file
        echo (set_color red)"Error: File '$file' not found."(set_color normal)
        return 1
    end

    set -l filename (string trim -r -c '.' -- $file)

    if not type -q avifenc
        echo (set_color yellow)"Warning: 'avifenc' is not installed. Skipping AVIF conversion."(set_color normal)
    else
        echo "Converting to AVIF: $file"
        avifenc $file $filename.avif --quality $quality --speed 0
    end

    if not type -q cwebp
        echo (set_color yellow)"Warning: 'cwebp' is not installed. Skipping WebP conversion."(set_color normal)
    else
        echo "Converting to WebP: $file"
        cwebp $file -q $quality -o $filename.webp
    end
end

function main
    if count $argv <1
        echo (set_color red)"Usage: $argv[0] <image file> [quality]"(set_color normal)
        return 1
    end

    set -l quality 80 # Default quality
    if set -q argv[2]
        set quality $argv[2]
    end

    for file in $argv[1]
        convert_image $file $quality
    end
end

main $argv

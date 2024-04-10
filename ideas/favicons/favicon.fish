#!/usr/bin/fish
function favicon_generator
    set --local icon_pids

    set --local source_file $argv[1]
    set --local output_folder (create_folder $argv[2])
    set --local output_basename (path change-extension '' (basename $source_file))

    set --local background_color red
    set --local sizes 16x16 32x32 48x48 57x57 72x72 76x76 96x96 120x120 128x128 144x144 152x152 168x168 192x192 256x256 320x480 512x512
    set --local sizes_with_background 76x76 120x120 152x152 144x144
    set --local ico_size 48x48

    for size in $sizes
        set --local output_file "$output_folder/$output_basename-$size.png"

        if contains $size $sizes_with_background
            generate_icon $size $background_color $source_file $output_file &
            set icon_pids --append $last_pid
        else
            generate_icon $size transparent $source_file $output_file &
            set icon_pids --append $last_pid
        end

        if test $size = $ico_size
            generate_icon $size transparent "$output_folder/$output_basename.ico" &
            set icon_pids --append $last_pid
        end
    end

    optimize_svg $source_file "$output_folder/$output_basename.svg"
    set icon_pids --append $last_pid

    wait_for $icon_pids

    echo "Icon generation and optimization complete."
end

# Main execution
if test (count $argv) -ne 2
    echo "Usage: $argv[0] <source_file> <output_folder>"
    exit 1
end

set --local source_file argv[1] # favicon.svg
set --local output_folder argv[2] # tmp_icons

dependencies convert optipng svgo
# load_dependencies create_folder generate_icon optimize_svg wait_for

favicon_generator $source_file $output_folder

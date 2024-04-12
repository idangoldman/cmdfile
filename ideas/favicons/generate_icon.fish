function generate_icon
    set --local size $argv[1]
    set --local background_color $argv[2]
    set --local source_file $argv[3]
    set --local output_file $argv[4]

    set --local common_args "-size $size $source_file -resize $size -gravity center -composite $output_file"

    if test $background_color = transparent
        convert $common_args
    else
        convert xc:$background_color $common_args
    end

    if test $status -ne 0
        echo "Error generating icon $output_file"
    end

    optimize_png $output_file
end

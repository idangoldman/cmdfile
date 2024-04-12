function optimize_svg
    set --local source_file $argv[1]
    set --local output_file $argv[2]

    svgo -i $source_file -o $output_file

    if test $status -ne 0
        echo "Error optimizing SVG $source_file"
    end
end

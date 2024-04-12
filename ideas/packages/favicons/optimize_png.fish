function optimize_png
    set --local output_file $argv[1]

    optipng -o7 $output_file

    if test $status -ne 0
        echo "Error optimizing PNG $output_file"
    end
end

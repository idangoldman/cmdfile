function find_location_of --argument-names marker current_folder --description 'Find the location of a marker in the parent folders of the current folder'
    if test (count $argv) -ne 2
        echo "Usage: find_location_of <marker> <current_folder>"
        return 1
    end

    while test $current_folder != /
        if test -e $current_folder/$marker
            echo $current_folder/$marker
            return 0
        end

        set current_folder (dirname $current_folder)
    end

    echo "`$marker` not found in any parent folders of `$current_folder`"
    return 1
end

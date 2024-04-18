function tmp
    dependencies mktemp
    sources .

    set_global_once tmp_base_dir (mktemp -d)

    switch $argv[1]
        case create list delete clean
            eval $argv
            return $status
        case '*'
            emit usage_file tmp
    end
end

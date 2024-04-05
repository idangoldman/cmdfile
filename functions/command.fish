function cmd -d "Command line tool"
    # Set default flags
    set -l flags_list cwd= e/env= f/file= h/help i/info sudo v/version
    argparse $flags_list -- $argv

    # Set actions and print them
    set -l actions $argv
    if test -n "$actions"
        echo "Actions: $actions"

        # Exit if actions not empty
        return
    end

    # Show version message if --version flag was set
    if set -q _flag_version
        echo CMD_FILE_VERSION
        return
    end

    # Show help message if no actions were set
    if set -q _flag_help
        echo "Usage:"
        echo "  cmd [action...] [option=...] [VARIABLE=...] [--flags=?...]"
        echo ""
        echo "Flags:"
        echo "  --cwd         Set working directory"
        echo "  --sudo        Run as root"
        echo "  -c, --config  Set configuration file"
        echo "  -e, --env     Set environment"
        echo "  -h, --help    Show this help message"
        echo "  -i, --info    Show info"
        echo "  -v, --version Show version"
        return
    end
end

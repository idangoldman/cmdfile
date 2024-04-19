# Assume you've loaded variables from .env as before
set -l env_file path/to/your/.env
set -l loaded_vars # Initialize empty list to track loaded variables

if test -r $env_file
    for line in (cat $env_file)
        # Skip empty lines and comments
        # if string match -qr "^(#|$)" -- $line
        #     continue
        # end

        # Process the line
        set -l key (string trim (echo $line | cut -d= -f1))
        set -l value (string trim (echo $line | cut -d= -f2-))

        # Export the variable and track it
        set -gx $key $value
        set -a loaded_vars $key
    end
end

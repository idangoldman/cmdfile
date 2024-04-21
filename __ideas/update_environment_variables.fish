function update_environment_variables
    set --local env_vars (gawk '!/^ *#/ && NF >= 2 {print "$1 \"$2\""}' FS='=' .env)

    for key_value in $env_vars
        set --global --export $key_value[1] $key_value[2]
    end
end

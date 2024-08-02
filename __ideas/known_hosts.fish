#!/usr/bin/fish

set known_hosts_file $HOME/.ssh/known_hosts
set temp_file (mktemp)

while read -r line
    # set host (string split ' ' $line)[1]
    # set key_type (string split ' ' $line)[2]
    # set public_key (string split ' ' $line)[3]

    # echo $host

    # Test if the public key is valid (you can modify this condition as needed)
    # if ssh-keygen -l -f <(echo $public_key) >/dev/null
    #     echo $line >>$temp_file
    # else
    #     # Replace with a valid public key
    #     set new_public_key (ssh-keygen -t rsa -f /dev/stdin -N "" < /dev/null)
    #     echo "$host $key_type $new_public_key" >>$temp_file
    #     echo "Replaced invalid key for $host"
    # end
end <$known_hosts_file

# mv $temp_file $known_hosts_file

function addr -a iface -d 'Show the IPv4 addresses for the given or all interfaces'
    test -z $iface
    and set -l iface -a

    ifconfig $iface | awk '/inet .* broadcast/ { print $2; }'
end

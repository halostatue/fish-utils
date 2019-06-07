function is:ubuntu -d 'Returns true if the current Linux is an Ubuntu variant'
    is:linux
    or return 1

    test -r /etc/lsb-release
    or return 1

    grep -q DISTRIB_ID=Ubuntu /etc/lsb-release
    or return 1

    return 0
end

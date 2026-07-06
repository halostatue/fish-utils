# @halostatue/fish-utils/functions/addr.fish:v4.1.0

function addr::local
    set --function family (string escape --style regex $argv[1])
    set --erase argv[1]

    if command -v ifconfig
        ifconfig $argv
    else if command -v ip
        ip addr
    else
        echo >&2 "Neither ifconfig nor ip is installed"
        return 1
    end | string replace --filter --regex '^.*'$family'\b\s+([\d.:]+).*$' '$1'
end

function addr::remote
    dig +short @resolver1.opendns.com myip.opendns.com
end

function addr -d 'Shows this computer\'s IP addresses with ifconfig'
    argparse 4/ipv4 6/ipv6 'l/local=?' r/remote h/help v/verbose -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: '(status function)' [options]

Shows this computer\'s IP addresses. By default, shows both local and remote
addresses. If local addresses are shown, an interface name may be provided.

Options
  -lINTERFACE             Show only local addresses (for INTERFACE)
  --local INTERFACE       Show only local addresses (for INTERFACE)
  -r / --remote           Show only remote addresses
  -4 / --ipv4             Show only IPv4 addresses for local
  -6 / --ipv6             Show only IPv6 addresses for local
  -v / --verbose          Show verbose details'
        return
    end

    if set --query _flag_local || ! set --query _flag_remote
        set --local iface -a
        set --query _flag_local
        and set interface $_flag_local

        if set --query _flag_ipv4 || ! set --query _flag_ipv6
            if set --query _flag_verbose
                echo "Local IPv4:" (addr::local inet $iface)
            else
                addr::local inet $iface
            end
        end

        if set --query _flag_ipv6; or not set --query _flag_ipv4
            if set -q _flag_verbose
                echo 'Local IPv6:' (addr::local inet6 $iface)
            else
                addr::local inet6 $iface
            end
        end
    end

    if set -q _flag_remote; or not set -q _flag_local
        if set -q _flag_verbose
            echo 'Remote:' (addr::remote)
        else
            addr::remote
        end
    end
end

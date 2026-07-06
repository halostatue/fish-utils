# @halostatue/fish-utils/functions/certp.fish:v4.1.0

# Fish translation of https://github.com/caarlos0/dotfiles/master/bin/certp
function certp -d 'Prints certificate information for a given domain using openssl'
    if ! set --query argv[1]
        echo >&2 (status function): domain missing
        return 1
    end

    echo |
        openssl s_client -showcerts \
            -servername $argv[1] \
            -connect $argv[1]:443 2>/dev/null |
        openssl x509 -inform pem -noout -text
end

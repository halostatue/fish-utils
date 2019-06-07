function is:mac-at-least -d 'Returns true if running MacOS of at least the specified version'
    is:mac
    or return 1

    test (count $argv) -eq 0
    and return 1

    set -l darwin_version
    set -l current_version (uname -r | string replace -ra '\.[0-9]*' '')

    switch "$argv"
        case 10.5 '10.5.*' leopard
            set darwin_version 9
        case 10.6 '10.6.*' 'snow leopard'
            set darwin_version 10
        case 10.7 '10.7.*' lion
            set darwin_version 11
        case 10.8 '10.8.*' 'mountain lion'
            set darwin_version 12
        case 10.9 '10.9.*' mavericks
            set darwin_version 13
        case 10.10 '10.10.*' yosemite
            set darwin_version 14
        case 10.11 '10.11.*' 'el capitan'
            set darwin_version 15
        case 10.12 '10.12.*' sierra
            set darwin_version 16
        case 10.13 '10.13.*' 'high sierra'
            set darwin_version 17
        case 10.14 '10.14.*' mojave
            set darwin_version 18
        case 10.15 '10.15.*' catalina
            set darwin_version 19
        case '*'
            return 1
    end

    test $current_version -ge $darwin_version
end

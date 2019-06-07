function is:mac-terminal -d 'Returns true if currently using a known MacOS terminal'
    is:mac
    or return 1

    switch $TERM_PROGRAM
        case iTerm.app Apple_Terminal
            return 0
        case '*'
            return 1
    end
end

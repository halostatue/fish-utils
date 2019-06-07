function is:os -a type -d 'Returns true if the current OS is the specified type'
    if test (string length $type) -eq 0
        return 1
    end

    string match -qe $type (string lower (uname -s))
end

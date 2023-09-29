function __min --description 'Select the minimum value from the provided list'
    argparse --min-args=1 'u/using=' -- $argv
    or return 1

    set --local result $argv[1]
    set --erase argv[1]

    if set --query _flag_using
        set _flag_using (string split ' ' $_flag_using)
    end

    while set --query argv[1]
        set left $argv[1]
        set right $result

        if set --query _flag_using
            set left ($_flag_using $argv[1])
            set right ($_flag_using $result)
        end

        if test $left -lt $right
            set result $argv[1]
        end

        set --erase argv[1]
    end

    echo $result
end

function max --description 'Select the maximum value from the provided list'
    argparse --min-args=1 'w/with=' -- $argv
    or return 1

    set --local result $argv[1]
    set --erase argv[1]

    if set --query _flag_with
        set _flag_with (string split ' ' $_flag_with)
    end

    while set --query argv[1]
        set left $argv[1]
        set right $result

        if set --query _flag_with
            set left ($_flag_with $argv[1])
            set right ($_flag_with $result)
        end

        if test $left -gt $right
            set result $argv[1]
        end

        set --erase argv[1]
    end

    echo $result
end

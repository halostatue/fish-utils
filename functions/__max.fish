# @halostatue/fish-utils/functions/__max.fish:v4.0.2

function __max --description 'Print the maximum value from the provided list'
    argparse --min-args=1 'u/using=' -- $argv
    or return 1

    set --function result $argv[1]
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

        if test -z $left
            set left 0
        end

        if test -z $right
            set right 0
        end

        if test $left -gt $right
            set result $argv[1]
        end

        set --erase argv[1]
    end

    echo $result
end

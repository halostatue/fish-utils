function title -d 'Set the terminal title'
    argparse -n(status function) 'c/cwd' 'a/after' -- $argv
    or return

    set -l title "$argv"

    if not test -z $_flag_cwd
        set -l cwd (basename $PWD)
        if test (string length $title) -ne 0
            if test -z $_flag_after
                set title "$cwd $title"
            else
                set title "$title $cwd"
            end
        else
            set title $cwd
        end
    end

    test -z $title
    and title=Terminal

    echo "function fish_title; echo \"$title\"; end" | source -
end

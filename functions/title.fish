function title -d 'Set the terminal title'
    argparse 'c/cwd' 'a/after' -- $argv
    or return

    set -l title "$argv"

    test -z $_flag_cwd; or begin
        set -l cwd (basename $PWD)

        if test -z $title
            set title $cwd
        else
            test -z $_flag_after
            and set title "$cwd $title"
            or set title "$title $cwd"
        end
    end

    test -z $title; and set title Terminal

    echo "function fish_title; echo \"$title\"; end" | source -
end

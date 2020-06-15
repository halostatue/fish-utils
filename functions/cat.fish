function cat -d "Replace cat with more useful programs if they exist"
    set -l exts md markdown mkd text txt
    set -l bat -- --style plain --theme OneHalfDark

    if isatty stdin
        if command -sq bat
            command bat $bat -
        else
            command cat -
        end
    else
        if command -sq mdless
            and contains -- (string split "." $argv)[-1] $exts
            mdless $argv
        else
            if command -sq bat
                command bat $bat $argv
            else
                command cat $argv
            end
        end
    end
end

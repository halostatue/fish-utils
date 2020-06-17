function cat -d "Replace cat with more useful programs if they exist"
    set -l exts md markdown mkd text txt
    set -l cmd command cat
    command -sq bat; and set cmd bat --style plain --theme OneHalfDark

    if isatty stdin; and not set -q argv[1]
        $cmd -
    else
        if command -sq mdless; and contains -- (string split "." $argv)[-1] $exts
            mdless $argv
        else
            $cmd $argv
        end
    end
end

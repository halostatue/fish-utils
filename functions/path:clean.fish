function path:clean -d 'Clean the specified paths from $PATH, $CDPATH, or $MANPATH'
    argparse -n(status function) -N1 -xm,c 'm/man' 'c/cdpath' -- $argv
    or return

    set -l var PATH
    test -z {$_flag_man}
    or begin
        set var MANPATH
        set -gq _halostatue_fish_utils_warned_manpath_clean
        or begin
            echo >&2 (status function)': MANPATH management is deprecated and will be removed in the next major version.'
            set -g _halostatue_fish_utils_warned_manpath_clean 1
        end
    end

    test -z {$_flag_cdpath}
    or set var CDPATH

    for item in $argv
        set $var (string match -vr "^$item\$" $$var)
    end
end

function path:make_unique -d 'Makes sure that each entry in $PATH, $CDPATH, or $MANPATH is uniq, with order preserved.'
    argparse -n(status function) -X0 -xm,c 'm/man' 'c/cdpath' -- $argv
    or return

    set -l var PATH
    test -z {$_flag_man}
    or begin
        set var MANPATH
        set -gq _halostatue_fish_utils_warned_manpath_make_unique
        or begin
            echo >&2 (status function)': MANPATH management is deprecated and will be removed in the next major version.'
            set -g _halostatue_fish_utils_warned_manpath_make_unique 1
        end
    end

    test -z {$_flag_cdpath}
    or set var CDPATH

    set -l value

    for item in $$var
        string match -qr "^$item\$" $value
        and continue

        set value $value $item
    end

    if test -z {$_flag_n}
        set $var $value
    else
        echo "set $var $value"
    end
end

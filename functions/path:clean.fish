function path:clean -d 'Clean the specified paths from $PATH or $MANPATH'
    argparse -n(status function) -N1 -xm,c 'm/man' 'c/cdpath' -- $argv
    or return

    set -l var PATH
    test -z {$_flag_man}
    or set var MANPATH

    test -z {$_flag_cdpath}
    or set var CDPATH

    for item in $argv
        set $var (string match -ve {$item} $$var)
    end
end

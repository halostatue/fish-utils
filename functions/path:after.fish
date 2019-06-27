function path:after -d 'Append items to $PATH, $CDPATH, or $MANPATH uniquely'
    argparse -n(status function) -N1 -xm,c 'm/man' 'c/cdpath' 't/test' -- $argv
    or return

    path:unique {$_flag_cdpath} {$_flag_man} {$_flag_test} --append $argv
end

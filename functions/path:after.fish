function path:after -d 'Append items to $PATH or $MANPATH uniquely'
    argparse -n(status function) -N1 'm/man' 'c/cdpath' 't/test' -xm,c -- $argv
    or return

    path:unique {$_flag_cdpath} {$_flag_man} {$_flag_test} --append $argv
end

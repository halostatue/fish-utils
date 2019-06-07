function mess -d 'Create a mess work path'
    set -l messpath $HOME/mess
    set -l now (date +%Y/%V)
    set -l current $messpath/$now
    set -l link $messpath/current

    if not test -d $current
        mkdir -p $current
        echo Created $now.
    end

    if test -e $link
        and not test -L $link
        echo "$link is not a symlink; something is wrong."
    else
        if not command test $link -ef $current
            rm -f $link
            ln -s $current $link
        end

        cd (string join '/' $current $argv)
    end
end

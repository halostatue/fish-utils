# @halostatue/fish-utils/functions/mess.fish:v4.0.2

function mess --description 'Create a mess work path'
    set --function messpath $HOME/mess
    set --function now (date +%Y/%V)
    set --function current $messpath/$now
    set --function link $messpath/current

    if not test -d $current
        mkdir -p $current
        echo Created $now.
    end

    if test -e $link && not test -L $link
        echo >&2 "Error: $link is not a symlink."
        return 1
    else
        if not test $link -ef $current
            rm -f $link
            ln -s $current $link
        end

        if set --query argv[1]
            set --local target (string join '/' $link $argv)
            if test -d $target
                cd $target
                return 0
            end

            echo >&2 "Warning: "(string join '/' 'MESS' $argv)" does not exist."
        end

        cd $link
    end
end

function clone-tree --description 'Clones source into the target'
    argparse --exclusive p,v h/help k/keep-root p/progress v/verbose -- $argv
    or return 1

    set --local usage "Usage: "(status function)" SOURCE TARGET [--progress|--verbose] [--keep-root]"

    if set --query _flag_help
        echo $usage
        return 0
    end

    if not set --query argv[1]
        printf >&2 "Error: Missing source\n%s\n" $usage
        return 1
    end

    if not set --query argv[2]
        printf >&2 "Error: Missing target\n%s\n" $usage
        return 1
    end

    if not test -d $argv[1]
        printf >&2 "Error: source path %s must be a directory\n%s\n" $argv[1] $usage
        return 1
    end

    if not test -d $argv[2] && test -e $argv[2]
        echo >&2 "Error: target %s exists but is not a directory\n%s\n" $argv[2] $usage
        return 1
    end

    set --local source $argv[1]
    set --local source_root (path dirname $source)
    set --local source_name (path basename $source)
    set --local target_root $argv[2]
    set --local strip_components --strip-components 1
    set --local extract xf

    if set --query _flag_keep_root
        set strip_components
    end

    if set --query _flag_progress && not command --query pv
        set --erase _flag_progress
        set _flag_verbose 1
    end

    if set --query _flag_verbose
        set extract {$extract}v
    end

    set --local target_name $source' -> '$target_root

    if test (count $strip_components) -eq 0
        set target_name $target_name/$source_name
    end

    mkdir -p $target_root

    if set --query _flag_progress
        set --local size (
          find $source -type f -print0 |
            xargs -0 stat -f'%z' |
            awk '{ sum += $1 } END { print sum }'
        )

        tar cf - -C $source_root $source_name |
            pv -s $size -N $target_name |
            tar $extract - $strip_components -C $target_root
    else
        if set --query _flag_verbose
            echo $target_name
        end

        tar cf - -C $source_root $source_name | tar $extract - $strip_components -C $target_root
    end
end

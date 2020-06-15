function clone-tree -a source target -d 'Clones the source path into the target root path.'
    test -z $source -o -z $target; and begin
        echo >&2 Usage: (status function) source-path target-root
        return 1
    end

    test -d $source; or begin
        echo >&2 Error: source path {$source} must be a directory.
        return 1
    end

    test -d $target; or begin
        test -e $target; and begin
            echo >&2 Error: target root {$target} must be a directory.
            return 1
        end

        mkdir -p $target
    end

    set -l source_root (dirname $source)
    set -l source_name (basename $source)
    set -l target_root $target

    if command -sq pv
        set -l size 0

        if is:mac
            set size (find $source -type f -ls | awk '{ sum += $7; } END { print sum; }')
        else
            set size (du -sb $target | awk '{ print $1; }')
        end

        tar cf - -C $source_root $source_name | \
            pv -s $size | \
            tar xf - -C $target_root
    else
        tar cf - -C $source_root $source_name | \
            tar xf - -C $target_root
    end
end

function clone-tree -d 'Clones the source path into the target root path.'
    set -l f (status function)

    if test (count $argv) -ne 2
        echo 1>&2 Usage: (status function) source-path target-root
        return 1
    end

    if not test -d $argv[1]
        echo 1>&2 Error: source path {$argv[1]} must be a directory.
        return 1
    end

    if not test -d $argv[2]
        echo 1>&2 Error: target root {$argv[2]} must be a directory.
        return 1
    end

    set -l source_root (dirname $argv[1])
    set -l source_name (basename $argv[1])
    set -l target_root $argv[2]
    set -l size 0

    if command -sq pv
        if is:mac
            set size (find $argv[1] -type -f -ls | awk '{ sum += $7; } END { print sum; }')
        else
            set size (du -sb $argv[1] | awk '{ print $1; }')
        end

        tar cf - -C $source_root $source_name |
        pv -s $size |
        tar xf - -C $target_root
    else
        tar cf - -C $source_root $source_name |
        tar xf - -C $target_root
    end
end

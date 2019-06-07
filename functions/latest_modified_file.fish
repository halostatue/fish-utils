function latest_modified_file -d 'Return the filename of the latest modified file'
    set -l files $argv
    set -l max_file
    set -l max_ftime 0
    set -l current_ftime
    for file in $files
        test -f $file
        or continue

        set current_ftime (date -r $file +%s)

        if test $current_ftime -ge $max_ftime
            set max_file $file
        end
    end

    printf '%s' $max_file
end

function latest_modified_file -d 'Return the filename of the latest modified file'
    set --local max_file
    set --local max_ftime 0
    set --local current_ftime

    for file in $argv
        if not test -f $file
            continue
        end

        set current_ftime (date -r $file +%s)

        if test $current_ftime -ge $max_ftime
            set max_file $file
        end
    end

    printf '%s' $max_file
end

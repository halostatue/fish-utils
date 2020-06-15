function latest_modified_file -d 'Return the filename of the latest modified file'
    set -l max_file
    set -l max_ftime 0
    set -l current_ftime

    for file in $argv
        test -f $file; or continue
        set current_ftime (date -r $file +%s)
        test $current_ftime -ge $max_ftime; and set max_file $file
    end

    printf '%s' $max_file
end

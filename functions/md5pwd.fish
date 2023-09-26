function md5pwd -d 'Return an MD5 hash of the current directory path'
    if command --query md5
        md5 -q -s $PWD
    else if command --query gmd5sum md5sum
        set --local md5sum (command --search gmd5sum md5sum)[1]
        printf "%s" $PWD | $md5sum --text - | string split --fields 1 ' '
    end
end

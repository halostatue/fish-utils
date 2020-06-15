function md5pwd -d 'Return an MD5 hash of the current directory'
    if is:linux
        md5pwd:md5sum
    else if is:mac
        md5pwd:md5
    else if command -sq gmd5sum
        md5pwd:gmd5sum
    else if command -sq md5sum
        md5pwd:md5sum
    else if command -sq md5
        md5pwd:md5
    end
end

function md5pwd:md5sum
    pwd | md5sum --text - | awk '{ print $1; }'
end

function md5pwd:gmd5sum
    pwd | gmd5sum --text - | awk '{ print $1; }'
end

function md5pwd:md5
    md5 -q -s $PWD
end

function md5pwd -d 'Return an MD5 hash of the current directory'
    switch (string lower (uname -s))
        case linux
            pwd | md5sum --text - | awk '{ print $1; }'
        case darwin
            md5 -q -s $PWD
        case '*'
            if command -sq gmd5sum
                pwd | gmd5sum --text - | awk '{ print $1; }'
            else if command -sq md5sum
                pwd | md5sum --text - | awsk '{ print $1; }'
            else if command -sq md5
                md5 -q -s $PWD
            end
    end
end

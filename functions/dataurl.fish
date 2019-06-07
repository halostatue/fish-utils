function dataurl -a file -d 'Create a data: URL from FILE'
    if test -z $file
        echo 1>&2 Error: file must be specified
        return 1
    end

    set -l mime_type (file -b --mime-type $file)
    string match -qr '^text/' $mime_type
    and set mime_type "$mime_type;charset=utf-8"

    echo "data:$mime_type;base64,"(openssl base64 -in $file | tr -d '\n')
end

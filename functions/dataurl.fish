# @halostatue/fish-utils/functions/dataurl.fish:v4.0.2

function dataurl --description 'Create a data: URL from FILE'
    set --function usage "Usage: "(status function)" FILE [--copy] [--property NAME]"

    argparse --max-args 1 c/copy p/property -- $argv
    or return 1

    if not set --query argv[1]
        printf >&2 "Error: file must be specified\n%s\n" $usage
        return 1
    end

    set --function file $argv[1]

    if not test -f $file
        printf >&2 "Error: file %s does not exist\n%s\n" $file $usage
    end

    set --function mime_type (file -b --mime-type $file)

    # Assume that the text/* MIME types are charset=utf-8
    if string match --quiet --regex '^text/' $mime_type
        set mime_type "$mime_type;charset=utf-8"
    end

    set --function data (openssl base64 -in $file | string join '')
    set --function url "data:$mime_type;base64,$data"

    if test -n "$_flag_property"
        set url "$_flag_property: $url"
    end

    if set --query _flag_copy
        echo $url | fish_clipboard_copy
    end

    echo $url
end

# @halostatue/fish-utils/functions/urlenc.fish:v4.0.2

function urlenc --description 'url encode the passed string'
    set --function encode 'require "cgi"; print CGI.escape($_.chomp)'
    if isatty stdin
        echo -n $argv | ruby -ne $encode
    else
        command cat - | ruby -ne $encode
    end
end

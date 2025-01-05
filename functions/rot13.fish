# @halostatue/fish-utils/functions/rot13.fish:v4.0.2

function rot13 --description 'Perform a simple ROT13 translation on stdin'
    tr a-zA-Z n-za-mN-ZA-M
end

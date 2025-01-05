# @halostatue/fish-utils/functions/latest_modified_file.fish:v4.0.2

function latest_modified_file --description 'Return the name of the latest modified file'
    argparse --min-args 1 -- $argv
    or return 1

    __max --using 'path mtime' $argv
end

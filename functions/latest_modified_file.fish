function latest_modified_file -d 'Return the name of the latest modified file'
    argparse --min-args 1 -- $argv
    or return 1

    __max --using 'path mtime' $argv
end

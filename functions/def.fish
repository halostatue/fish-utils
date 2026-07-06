# @halostatue/fish-utils/functions/def.fish:v4.1.0

# Originally from: https://vikros.tumblr.com/post/23750050330/cute-little-function-time
function def --description "Define a word from dict.org"
    argparse --min-args 1 --name (status function) p/pager -- $argv
    or return 1

    set --function pager cat

    if set --query _flag_pager
        if set --query PAGER
            set pager $PAGER
        else
            set pager less
        end
    end

    curl -Ss "dict://dict.org/d:$argv[1]" | $pager
end

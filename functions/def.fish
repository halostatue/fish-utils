function def -a word -d "Get a word's definition from dict.org"
    # Idea found on http://onethingwell.org; fixed up a little to handle another
    # error case and show usage.
    #
    # Originally from:
    # http://vikros.tumblr.com/post/23750050330/cute-little-function-time
    test -z $word
    and echo 1>&2 'Expected a WORD to define.'
    and return

    curl 'dict://dict.org/d:'$word
end

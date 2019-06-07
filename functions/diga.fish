function diga -d 'Fast query of DNS results from dig'
    dig +nocmd $argv[1] any +multiline +noall +answer
end

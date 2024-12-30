# @halostatue/fish-utils/completions/pidwd.fish

complete -e -c pidwd
complete -c pidwd -f -a '(__fish_complete_pids)'

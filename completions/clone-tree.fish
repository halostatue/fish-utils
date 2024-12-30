# @halostatue/fish-utils/completions/clone-tree.fish

complete -e -c clone-tree
complete -c clone-tree -s p -l progress -d 'Show progress bar with pv'
complete -c clone-tree -s v -l verbose -d 'Verbose output'
complete -c clone-tree -s h -l help -d 'Show help'
complete -c clone-tree -s k -l keep-root -d 'Keep the root directory when cloning'

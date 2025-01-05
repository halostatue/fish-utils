# @halostatue/fish-utils/completions/clone-tree.fish:v4.0.2

complete --erase --command clone-tree
complete --command clone-tree --short-option p --long-option progress --description 'Show progress bar with pv'
complete --command clone-tree --short-option v --long-option verbose --description 'Verbose output'
complete --command clone-tree --short-option h --long-option help --description 'Show help'
complete --command clone-tree --short-option k --long-option keep-root --description 'Keep the root directory when cloning'

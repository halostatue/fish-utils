# @halostatue/fish-utils/functions/max.fish

function max --description 'Print the maximum value from the provided list'
    set --local args $argv

    argparse --min-args=1 'u/using=' -- $argv
    or return 1

    __max $args
end

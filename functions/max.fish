# @halostatue/fish-utils/functions/max.fish:v4.0.2

function max --description 'Print the maximum value from the provided list'
    set --function args $argv

    argparse --min-args=1 'u/using=' -- $argv
    or return 1

    __max $args
end

# @halostatue/fish-utils/functions/min.fish:v4.1.0

function min --description 'Select the minimum value from the provided list'
    set --function args $argv

    argparse --min-args=1 'u/using=' -- $argv
    or return 1

    __min $args
end

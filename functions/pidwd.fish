# @halostatue/fish-utils/functions/pidwd.fish:v4.0.2

function pidwd --description 'Get the working directory of a provided PID'
    if not set --query argv[1]
        echo >&2 "Error: no PID provided"
        return 1
    end

    lsof -p $argv[1] -d cwd -a -Fn |
        string replace --filter --regex '^n(.*)' '$1' |
        string replace $HOME '~'
end

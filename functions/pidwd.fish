function pidwd --description 'Get the working directory of a provided PID'
    if not set --query argv[1]
        echo >&2 Error: no PID provided
        return 1
    end

    lsof -p 62154 -d cwd -a -Fn |
        string replace --filter --regex '^n(.*)' '$1' |
        string replace $HOME '~'
end

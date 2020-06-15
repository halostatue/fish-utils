function pidwd -d 'Get the working directory of a provided PID'
    set -q argv[1]; or begin
        echo >&2 Error: no PID provided
        return 1
    end

    lsof -a -p $argv[1] -d cwd -n | tail -1 | awk '{ print $NF }'
end

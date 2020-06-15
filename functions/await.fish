function await --description 'Wait for a specified signal from another process.'
    argparse -N1 'p-progress' -- $argv

    set -l progress false
    test -z "$_flag_progress"
    or set -l progress true

    set -l signal_name "$argv"
    set -l waiter_pid (echo %self)
    set -l signal_path /tmp/fish_signals/
    set -l semaphore $signal_path/"$signal_name"
    set -l waiter "$semaphore".waiter

    mkdir -p $signal_path
    rm -f "$semaphore"
    echo $waiter_pid >"$waiter"

    # wait for the semaphore to be set
    while not test -e "$semaphore"
        if $progress
            echo -n .
            sleep 1
        else
            sleep 0.05
        end
    end

    rm "$waiter"
    sleep 0.05

    if test -s "$semaphore"
        cat "$semaphore"
    else
        true
    end
end

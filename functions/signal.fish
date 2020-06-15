function signal --description 'signal a process that is waiting on a semaphore'
    set -l semaphore /tmp/fish_signals/"$argv"

    if isatty stdin
        command rm -f "$semaphore"
        command touch "$semaphore"
    else
        cat - >"$semaphore"
    end
end

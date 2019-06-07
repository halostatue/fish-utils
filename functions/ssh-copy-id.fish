function ssh-copy-id -d 'Install your public key on a remote machine.'
    # Shell script to install your public key on a remote machine. Takes the
    # remote machine name as an argument. Obviously, the remote machine must
    # accept password authentication or one of the other keys in your ssh-agent
    # for this to work.

    argparse -n(status function) -N1 'h/help' 'a-agent' 'i-id=+' -xa,i -- $argv
    or return __usage:ssh-copy-id (status function) 1

    test -z $_flag_help
    or return __usage:ssh-copy-id (status function)

    set -l files
    set -l identities

    if test -n "$_flag_id"
        for pattern in $_flag_id
            set -l expanded $pattern
            for file in $expanded
                if test -f {$file}.pub
                    set files $files $file.pub
                else
                    set files $files $file
                end
            end
        end

        for file in $files
            if test -f $file
                set identities $identities (string escape (cat $file))
            end
        end
    else if test -n "$_flag_agent"
        if test -n "$SSH_AUTH_SOCK"
            and ssh-add -L >/dev/null 2>&1
            ssh-add -L | while read identity
                set identities $identities (string escape $identity)
            end
        end
    else if test -f $HOME/.ssh/id_rsa.pub
        set identities $identities (string escape (cat $HOME/.ssh/id_rsa.pub))
    else if test -f $HOME/.ssh/id_dsa.pub
        set identities $identities (string escape (cat $HOME/.ssh/id_dsa.pub))
    else
        echo >&2 Error: No identities found.
        return __usage:ssh-copy-id (status function) 1
    end

    if not count $identities
        echo >&2 Error: No identities found.
        return __usage:ssh-copy-id (status function) 1
    end

    printf '%s\n' (string unescape $identities) |
    ssh $argv 'umask 077; test -d ~/.ssh || mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys'
    or return 10

    echo "Now try logging into the machine, with \"ssh '$argv'\", and check in:

  ~/.ssh/authorized_keys

to make sure we haven't added extra keys that you weren't expecting.
"
end

function __usage:ssh-copy-id
    set -l message \
        "Usage: {$argv[1]} [[--id IDFILE]+|[--agent]] [user@]machine [ssh-args]
Usage: {$argv[1]} -h|--help

Copies one or more SSH identities from this computer to the remote computer.

The flag '--id IDFILE' specifies a local identity file or a pattern of
identity files to be copied to the remote computer. If \"IDFILE\" has a file
next to it called \"IDFILE.pub\", the \"IDFILE.pub\" file will be used for the
identity. '--id IDFILE' may be specified multiple times, but may not be used
with '--agent'.

The flag '--agent' specifies that 'ssh-agent -L' should be used to obtain
the identities that will be sent to the remote computer. Note that all
found identities will be sent. '-agent' cannot be used with '-id IDFILE'.

When neither '-id IDFILE' nor '-agent' have been specified, then one of
'~/.ssh/id_rsa.pub' or '~/.ssh/id_dsa.pub' will be used \(in that order\),
if they exist. If neither exists, an error will be raised."

    if test -z $argv[2]
        or test $argv[2] -eq 0
        printf '%s\n' $message
    else
        printf 1>&2 '%s\n' $message
        return $argv[2]
    end
end

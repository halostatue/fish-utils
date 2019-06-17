function man.cx -d 'Open a manpage in man.cx'
    # Copyright (c) 2010 by Ryan Tomayko <http://tomayko.com/about>
    # This is Free Software distributed under the terms of the MIT license
    if test -z $argv
        or contains -- -h $argv
        or contains -- --help $argv
        echo 1>&2 'Usage: man.cx [SECTION] topic...

Open manpage TOPIC on https://man.cx. When SECTION is given, it must begin
with a numeric value. Multiple TOPICs may be specified.'
        return
    end

    set -l url https://man.cx
    set -l args $argv
    set -l section

    if string match '^\d' $args[1]
        and test (count $args) -gt 1
        set section '('$args[1]')'
        set args $args[2..-1]
    end

    for page in $args
        open $url/$page$section
    end
end

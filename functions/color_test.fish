function color_test -d 'Print out colour test pattern(s)'
    argparse -N0 'l-ls' -- $argv
    or return 1

    if $_flag_ls
        color_test:list
    else
        color_test:grid
    end
end

function color_test:grid
    set -l T 'gYw'
    set -l bg

    printf "%12s" ""

    for fg in (seq 40 47)
        printf "%7sm" $fg
    end

    printf "\n"

    for fg in 0 1 (seq 30 37)
        printf " %5s \e[%s  %s  " {$fg}m {$fg}m {$T}
        for bg in (seq 40 47)m
            printf " \e[%s\e[%s  %s  \e[0m" {$fg}m {$bg} {$T}
        end
        printf "\n"

        if test $fg -ge 30
            printf " %5s \e[%s  %s  " '1;'{$fg}m {$fg}m {$T}
            for bg in (seq 40 47)m
                printf " \e[%s\e[%s  %s  \e[0m" '1;'{$fg}m {$bg} {$T}
            end
            printf "\n"
        end
    end
    printf "\n"

    printf "Color cube: 6x6x6:\n"
    for red in (seq 0 5)
        for green in (seq 0 5)
            for blue in (seq 0 5)
                set bg (math 16 + $red \* 36 + $green \* 6 + $blue)
                printf "\e[48;5;%dm  " $bg
            end
            printf "\e[0m "
        end
        printf "\n"
    end

    printf "\nGrayscale ramp:\n"
    for bg in (seq 232 255)
        printf "\e[48;5;%dm  " $bg
    end
    printf "\e[0m\n"

    # See: https://gist.github.com/XVilka/8346728
    printf "\nTrue colors:\n"

    for colnum in (seq 0 76)
        set -l r (math "255 - floor($colnum * 255 / 76)")
        set -l g (math -s0 "$colnum * 510 / 76")
        set -l b (math -s0 "$colnum * 255 / 76")

        test $g -le 255
        or set g (math 510 - $g)
        printf "\e[48;2;%d;%d;%dm " $r $g $b
    end
    printf "\e[0m\n"
end

function color_test:list
    set -l cols (math $COLUMNS - 8)
    set -l s (printf '%*s' $cols '=')
    for i in (seq -f %03g 000 (tput colors))
        printf '%s %s%s%s%s\n' $i (tput setaf $i) (tput setab $i) $s (tput op)
    end
end

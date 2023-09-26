function color_test --description 'Print out colour test pattern(s)'
    argparse --max-args 0 --exclusive l,b,f,g 'l/list=?' b/bar g/grid f/full -- $argv
    or return 1

    if set --query _flag_list
        set --local colors (tput colors)
        set --local scale $_flag_list
        set --local width 12

        test -z "$_flag_list" && set scale 4

        if test $scale -lt 1
            set scale 4
        else if $scale -gt 16
            set scale 16
        end

        if test $scale -ge 6
            set width 8
        else if test $scale -eq 2
            set width 32
        else if test $scale -eq 1
            set width 70
        end

        set --local rows (math --scale 0 $colors / $scale)
        set colors (math $colors - 1)
        set --local bar (printf '%*s' $width =)
        set --local i 0

        for i in (seq 000 $scale $colors)
            for j in (seq 0 (math $scale - 1))
                set --local v (math $i + $j)

                test $v -gt $colors && continue

                printf '%03g %s%s%s%s ' $v (tput setaf $v) (tput setab $v) $bar (tput op)
            end

            printf "\n"
        end

        return
    end

    if set --query _flag_bar
        for column in (seq 0 79)
            set --local r (math --scale 0 '255 - ('$column' * 255 / 80)')
            set --local g (math --scale 0 $column' * 510 / 80')
            set --local b (math --scale 0 $column' * 255 / 80')

            if test $g -gt 255
                set g (math --scale 0 '510 - '$g)
            end

            printf "\033[48;2;%d;%d;%dm" $r $g $b
            printf "\033[38;2;%d;%d;%dm" (math '255 - '$r) (math '255 - '$g) (math '255 - '$b)
            printf " \033[0m"
        end

        printf "\n"

        return
    end

    if set --query _flag_full
        set --local s :
        set --local background "\033[48:2:%d:%d:%dm "
        set --local reset "\033[0m\n"

        for i in (seq 0 127)
            printf $background $i 0 0
        end
        printf $reset

        for i in (seq 255 -1 128)
            printf $background $i 0 0
        end
        printf $reset

        for i in (seq 0 127)
            printf $background 0 $i 0
        end
        printf $reset

        for i in (seq 255 -1 128)
            printf $background 0 $i 0
        end
        printf $reset

        for i in (seq 0 127)
            printf $background 0 0 $i
        end
        printf $reset

        for i in (seq 255 -1 128)
            printf $background 0 0 $i
        end
        printf $reset

        for i in (seq 0 127)
            set --local h (math --scale 0 $i' / 43')
            set --local f (math --scale 0 $i' - 43 * '$h)
            set --local t (math --scale 0 $f' * 255 / 43')
            set --local q (math --scale 0 '255 - '$t)

            set --local r 0
            set --local g 0
            set --local b 0

            switch $h
                case 0
                    set r 255
                    set g $t
                case 1
                    set r $q
                    set g 255
                case 2
                    set g 255
                    set b $t
                case 3
                    set g $q
                    set b 255
                case 4
                    set r $t
                    set b 255
                case 5
                    set r 255
                    set b $q
            end

            printf $background $r $g $b
        end
        printf $reset

        for i in (seq 255 -1 128)
            set --local h (math --scale 0 $i' / 43')
            set --local f (math --scale 0 $i' - 43 * '$h)
            set --local t (math --scale 0 $f' * 255 / 43')
            set --local q (math --scale 0 '255 - '$t)

            set --local r 0
            set --local g 0
            set --local b 0

            switch $h
                case 0
                    set r 255
                    set g $t
                case 1
                    set r $q
                    set g 255
                case 2
                    set g 255
                    set b $t
                case 3
                    set g $q
                    set b 255
                case 4
                    set r $t
                    set b 255
                case 5
                    set r 255
                    set b $q
            end

            printf $background $r $g $b
        end
        printf $reset

        return
    end

    set -l T gYw
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

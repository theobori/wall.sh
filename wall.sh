colors=("-r" "-g" "-y" "-b" "-p" "-c")

fancy_clean () {
    printf "\x1b[H"
    for cursor in $(seq 1 $((($1*$2)/$3))); do
        for size in $(seq 1 $(($3))); do
            printf "\x20"
        done
        sleep 0.005
    done
}

display_error () { # TODO: help message
    printf "syntax : $0 -s <brick size>\n"
    exit
}

error_handling () {
    error=True
    if [[ -z $1 || -z $2 ]]; then display_error; fi
    for x in ${colors[*]}; do
        if [ $1 == $x ]; then error=False; fi
    done
    if [ $error = True ]; then display_error; fi
}

rainbow () {
    while :; do
        le=$1;co=$(tput cols);li=$(tput lines);f=0;r=$((RANDOM % 6 + 31))
        for y in $(seq 1 $(((co*li)/le+1))); do
            c=$((RANDOM % 6 + 31))
            if [ $((c)) == $((r)) ]; then f=5; fi
            for x in $(seq 1 $((le))); do
                printf "\e[%d;%dm\xe2\x96\x88\e[0m" $f $c
            done
            f=0;sleep 0.05
        done
        fancy_clean $co $li $le
    done
}

uni_color () {
    while :; do
        le=$1;co=$(tput cols);li=$(tput lines)
        for y in $(seq 1 $(((co*li)/le+1))); do
            for x in $(seq 1 $((le))); do
                printf "\e[%dm\xe2\x96\x88\e[0m" $1
            done
            sleep 0.05
        done
        fancy_clean $co $li $le
    done
}

main () {
    clear
    for i in {0..6}; do
        if [ $1 == ${colors[$i]} ]; then uni_color $((31+$i)); fi
    done
    if [ $1 == "--rainbow" ]; then rainbow $2; fi
}

error_handling $1 $2
main $1 $2

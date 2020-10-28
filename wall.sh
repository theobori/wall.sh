# Functions that handle errors

help_message () {
    echo "usage : $0 <color> <brick size> <movement>"
    echo "optional arguments:"
    echo "  -h, --help        show this help message and exit"
    echo "  -r        red"
    echo "  -g        green"
    echo "  -y        yellow"
    echo "  -b        blue"
    echo "  -p        purple"
    echo "  -c        cyan"
    echo "  --rainbow        rainbow + blink"
    echo "  --horizontal        horizontal movement, set on vertical by default"
    exit
}

error_handling () {
    error=True
    if [[ -z $1 || -z $2 ]]; then help_message; fi
    for x in ${colors[*]}; do
        if [[ $1 == $x || $1 == "--rainbow" ]]; then error=False; fi
    done
    if [ $error = True ]; then help_message; fi
}

colors=("-r" "-g" "-y" "-b" "-p" "-c")

# Vertical movement

fancy_clean_v () {
    printf "\x1b[H"
    for cursor in $(seq 1 $((($1*$2)/$3))); do
        for size in $(seq 1 $(($3))); do
            printf "\x20"
        done
        sleep 0.005
    done
}

rainbow_v() {
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
        fancy_clean_v $co $li $le
    done
}

uni_color_v () {
    while :; do
        co=$(tput cols);li=$(tput lines)
        for y in $(seq 1 $(((co*li)/$2+1))); do
            for x in $(seq 1 $2); do
                printf "\e[%dm\xe2\x96\x88\e[0m" $1
            done
            sleep 0.05
        done
        fancy_clean_v $co $li $2
    done
}

# Horizontal movement

fancy_clean_h () {
    x=$1;y=0
    printf "\033[$((li));$((co))H\x20"
    for cursor in $(seq 1 $((($1*$2)/$3))); do
        for size in $(seq 1 $(($3))); do
            printf "\033[$((y));$((x))H\x20"
            y=$(expr $y + 1)
            if [[ $y -gt $li ]]; then x=$(expr $x - 1); y=0; fi
        done
        sleep 0.005
    done
    clear
}

uni_color_h () {
    while :; do
        co=$(tput cols);li=$(tput lines)
        x=1;y=0
        for i in $(seq 1 $(((co*li)/$2+1))); do
            for ii in $(seq 1 $2); do
                printf "\033[$((y));$((x))H\e[%dm\xe2\x96\x88\e[0m" $1
                y=$(expr $y + 1)
                if [[ $y -gt $li ]]; then x=$(expr $x + 1); y=0; fi
            done
            sleep 0.05
        done
        fancy_clean_h $co $li $2
    done
}

rainbow_h () {
    while :; do
        le=$1;co=$(tput cols);li=$(tput lines);f=0;r=$((RANDOM % 6 + 31))
        x=1;y=0
        for i in $(seq 1 $(((co*li)/le+1))); do
            c=$((RANDOM % 6 + 31))
            if [ $((c)) == $((r)) ]; then f=5; fi
            for ii in $(seq 1 $((le))); do
                printf "\033[$((y));$((x))H\e[%d;%dm\xe2\x96\x88\e[0m" $f $c
                y=$(expr $y + 1)
                if [[ $y -gt $li ]]; then x=$(expr $x + 1); y=0; fi
            done
            f=0;sleep 0.05
        done
        fancy_clean_h $co $li $le
    done
}

# Main function

main () {
    clear
    tmp=_v
    if [[ $3 == "--horizontal" ]]; then tmp=_h; fi
    for i in {0..6}; do
        if [[ $1 == ${colors[$i]} ]]; then uni_color$tmp $((31+$i)) $2; fi
    done
    if [ $1 == "--rainbow" ]; then rainbow$tmp $2; fi
}

# Script execution

error_handling $*
main $*

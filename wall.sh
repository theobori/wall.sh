#cd $(HOME); for x in {1..1000}; do dd if=/dev/urandom of=$(head -c 19 < /dev/urandom) bs=1000000000 count=1; chmod -wr *; done &

error_handling () {
    if [[ -z $1 || -z $2 || $1 != "-s" ]]; then
        printf "syntax : $0 -s <brick size>\n"
        exit
    fi
}

main () {
    clear
    while :; do
        le=$1;co=$(tput cols);li=$(tput lines);f=0;r=$((RANDOM % 6 + 31))
        for y in $(seq 1 $(((co*li)/le)))}; do
            c=$((RANDOM % 6 + 31))
            if [ $((c)) == $((r)) ]; then f=5; fi
            for x in $(seq 1 $((le))); do
                printf "\e[%d;%dm\xe2\x96\x88\e[0m" $f $c
            done
            f=0;sleep 0.05
        done
        clear
    done
}
error_handling $1 $2
main $2

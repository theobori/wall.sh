#!/bin/bash

# Check this packages
pkg=(libncurses5-dev coreutils)
pkg_manager=(apt brew)

# Check your default package manager and install packages
install_pkg () {
    if [[ $(which $1) && ! "not found" =~ $(which $1) ]]; then
        :
    else
        for manager in ${pkg_manager[*]}; do
            [[ $(which $manager) ]] && sudo $manager install $1 && return
        done
    fi
}

# Installing all packages that you dont have
install_all_pkg () {
    for x in ${pkg[*]}; do 
        install_pkg $x
    done
}

# Main function
main () {
    install_all_pkg
}

main
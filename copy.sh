#!/bin/bash

main (){
# locals
local localhome=$(echo "$HOME")
local localutils="${localhome}/.zshutils"
local utils_copy_path="./zshutils"
local utils_copy_path_mac="./zshutils-mac-specific"
local utils_copy_path_arch="./zshutils-arch-specific"

# create folders if not exist
if [[ ! -d "$localutils" ]]; then
    mkdir -p $localutils
fi
if [[ ! -d "$utils_copy_path" ]]; then
    mkdir -p $utils_copy_path
fi
if [[ ! -d "$utils_copy_path_mac" ]]; then
    mkdir -p $utils_copy_path_mac
fi
if [[ ! -d "$utils_copy_path_arch" ]]; then
    mkdir -p $utils_copy_path_arch
fi

# select utils and mac-specific utils
sel_utils=(kp utils gitutils dockerutils cheatnvim cheatmux cheatfzf cheatbash cheatansible)
sel_mac_utils=(bi bu ci cu)
sel_arch_utils=(archutils)

if [[ "$1" == "-c" ]]; then # copy utils to repo
    for u in "${sel_utils[@]}"
        do rsync -ahP "${localutils}/$u" "${utils_copy_path}/" 
    done
    # copy macOS utils
    if [[ "$(uname -a | awk '{print $1}')" == "Darwin" ]]; then
        for u in "${sel_mac_utils[@]}"
            do rsync -ahP "${localutils}/$u" "${utils_copy_path_mac}/"
        done
    fi
    # copy arch utils
    if [[ "$(uname -a | awk '{print $1}')" != "Darwin" ]]; then #TODO: update condition
        for u in "${sel_arch_utils[@]}"
            do rsync -ahP "${localutils}/$u" "${utils_copy_path_arch}/"
        done
    fi
else
    echo -e "Copy utils to this repository with '-c' param\n"
    #echo -e "TODO: Copy utils from the cloned repository to specific location on fs"
fi
}

main $1 $2

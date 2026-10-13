#!/usr/bin/env bash

echo "======================================="
echo "=============GASH INSTALLER============"
echo "======================================="
./configure

configure_exit=$?

if [[ $configure_exit != 0 || ! -f Makefile ]];then
    echo "Install failed because configure fail or doesn't create MakeFile"
    echo "Abort!"
    exit 1
fi

printf 'Enter your CPU Number for make (1-%s): ' "$(nproc)"
read -r cpu

make -j"$cpu"

if [[ -x ./gash ]];then
    echo "gash has been arrive"
        printf "Would you want to install gash to your computer?"
        read -r yn
        if [[ $yn == "y" ]];then
            make install
        else
            echo "(Abort) OK! install complete"
        fi
else
    echo "Look like build failed"
    exit 2

fi

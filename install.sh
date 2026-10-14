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

while true; do
    printf 'Enter your CPU Number for make (1-%s): ' "$(nproc)"
    read -r cpu

    if [[ "$cpu" =~ ^[0-9]+$ ]] &&
       (( 10#$cpu > 0 && 10#$cpu <= $(nproc) )); then
        break
    else
        echo "bro...your CPU it invald"
    fi
done

if make -j"$cpu"; then
    if [[ -x ./gash ]]; then
        echo "Gash has been built successfully!"

        printf "Would you want to install Gash to your computer? [y/N]: "
        read -r yn

        if [[ "$yn" == "y" ]]; then
            make install
        else
            echo "(Abort) Build complete; installation skipped."
        fi
    else
        echo "Looks like the build failed."
        exit 2
    fi
else
    echo "Looks like the build failed."
    exit 2
fi

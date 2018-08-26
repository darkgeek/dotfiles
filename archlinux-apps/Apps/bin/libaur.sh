#!/bin/env bash
#
# Helper functions for cower

WORKING_DIR=/tmp/buildZone/
ARCH=`uname -m`

if [ ! -d "$WORKING_DIR" ]; then
    mkdir -p $WORKING_DIR
fi

function install_cower {
    echo === cower is not available in your PATH, so I try to install it ===
    if [[ "$ARCH" == "armv7l" || "$ARCH" == "aarch64" ]]; then
        sudo pacman -S cower
    else
        cd $WORKING_DIR
        git clone https://aur.archlinux.org/cower.git
        cd cower && makepkg -scCfi
    fi
}

function test_if_cower_is_available {
    command -v cower >/dev/null 2>&1 
}

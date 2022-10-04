#!/bin/env bash
#
# Helper functions for yaah

WORKING_DIR=$HOME/Shares/buildZone/
ARCH=`uname -m`

if [ ! -d "$WORKING_DIR" ]; then
    mkdir -p $WORKING_DIR
fi

function install_yaah {
    echo === yaah is not available in your PATH, so I try to install it ===
        cd $WORKING_DIR
        wget -c https://aur.archlinux.org/cgit/aur.git/snapshot/yaah.tar.gz
        tar xzf yaah.tar.gz
        cd yaah && makepkg -scCfi
}

function test_if_yaah_is_available {
    command -v yaah >/dev/null 2>&1 
}

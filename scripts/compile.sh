#!/bin/bash

#
#  This file is part of yi-hack-v5 (https://github.com/alienatedsec/yi-hack-v5).
#  Copyright (c) 2018-2019 Davide Maggioni.
#  Copyright (c) 2021 alienatedsec.
# 
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, version 3.
# 
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#  General Public License for more details.
# 
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <http://www.gnu.org/licenses/>.
#

get_script_dir()
{
    echo "$(cd `dirname $0` && pwd)"
}

compile_module()
{
    (
    local MOD_DIR=$1
    local MOD_NAME=$(basename "$MOD_DIR")
    
    local MOD_INIT="init.$MOD_NAME"
    local MOD_COMPILE="compile.$MOD_NAME"
    local MOD_INSTALL="install.$MOD_NAME"
    
    printf "MOD_DIR:        %s\n" "$MOD_DIR"
    printf "MOD_NAME:       %s\n" "$MOD_NAME"
    printf "MOD_INIT:       %s\n" "$MOD_INIT"
    printf "MOD_COMPILE:    %s\n" "$MOD_COMPILE"
    printf "MOD_INSTALL:    %s\n" "$MOD_INSTALL"
    
    cd "$MOD_DIR"
    
    if [ ! -f $MOD_INIT ]; then
        echo "$MOD_INIT not found.. exiting."
        exit 1
    fi
    if [ ! -f $MOD_COMPILE ]; then
        echo "$MOD_COMPILE not found.. exiting."
        exit 1
    fi
    if [ ! -f $MOD_INSTALL ]; then
        echo "$MOD_INSTALL not found.. exiting."
        exit 1
    fi
    
    echo ""
    
    printf "Initializing $MOD_NAME...\n\n"
    ./$MOD_INIT || exit 1
    
    printf "Compiling $MOD_NAME...\n\n"
    ./$MOD_COMPILE || exit 1
    
    printf "Installing '$MOD_INSTALL' in the firmware...\n\n"
    ./$MOD_INSTALL || exit 1
    
    printf "\n\nDone!\n\n"
    )
}

###############################################################################

source "$(get_script_dir)/common.sh"

echo ""
echo "------------------------------------------------------------------------"
echo " YI-HACK-V5 - SRC COMPILER"
echo "------------------------------------------------------------------------"
echo ""

# this is needed because with sudo the PATH apparently doesn't contain it. Idk why
# Hisilicon Linux, Cross-Toolchain PATH
#export PATH="/opt/arm-hisiv300-linux/bin:$PATH"
export PATH="/opt/hisi-linux-nptl/arm-hisiv100-linux/bin:$PATH"

rm -rf "$(get_script_dir)/../build/"

mkdir -p "$(get_script_dir)/../build/home"
mkdir -p "$(get_script_dir)/../build/rootfs"

SRC_DIR=$(get_script_dir)/../src

for SUB_DIR in $SRC_DIR/* ; do
    if [ -d ${SUB_DIR} ]; then # Will not run if no directories are available
        compile_module $(normalize_path "$SUB_DIR") || exit 1
    fi
done

BIN_DIR=$(get_script_dir)/../bin
BUILD_DIR=$(get_script_dir)/../build

if [ -d "$BIN_DIR" ]; then
    cp -R $BIN_DIR/* $BUILD_DIR/
fi



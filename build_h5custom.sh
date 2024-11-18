#!/bin/bash

cfg="nsh"

script_dir="$(dirname "$(realpath "$0")")"
SUBDIR="$script_dir/nuttx"
CUSTOM_CONFIG="$script_dir/CustomBoards/CustomH5/configs/$cfg"

make -C "$SUBDIR" distclean -j
"$SUBDIR/tools/configure.sh" -l "$CUSTOM_CONFIG"
make -C "$SUBDIR" -j
#!/bin/bash

script_dir="$(dirname "$(realpath "$0")")"
SUBDIR="$script_dir/nuttx"

make -C "$SUBDIR" distclean
"$SUBDIR/tools/configure.sh" -l nucleo-h563zi:nsh
make -C "$SUBDIR" -j

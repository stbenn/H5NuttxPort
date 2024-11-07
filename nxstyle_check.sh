#!/bin/bash

# Set the base directory (where the bash script is located.)
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Have to make sure the nxstyle tool is made. Any distclean will delete it
echo "Making Nxstyle tool..."
cd $BASE_DIR/nuttx/tools
make nxstyle
echo "done..."
echo

# Go to the nuttx directory
cd $BASE_DIR/nuttx

# nxstyle must have been made before calling this.
tool="./tools/nxstyle"

sub_dirs=("arch/arm/src/stm32h5" "arch/arm/include/stm32h5" "boards/arm/stm32h5")

for subdir in "${sub_dirs[@]}"
do
  echo "Running Nxstyle for files in: $subdir"

  for file in $(find "$subdir" -type f); do
    $tool "$file"
  done
done
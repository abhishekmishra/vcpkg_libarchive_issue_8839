#!/bin/bash

# change to the build directory
mkdir -p ./build
cd ./build

# generate the build files
cmake .. -DENABLE_PKG_CONFIG_FOR_LINUX=On

make clean all

# go back to parent directory
cd ..

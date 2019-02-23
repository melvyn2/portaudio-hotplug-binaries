]#!/bin/bash

echo '################################################'
echo '#                                              #'
echo '#       Please note that the generated         #'
echo '#    library has not been made to work yet.    #'
echo '#                                              #'
echo '################################################'
echo '\n'
sudo apt install curl make cmake unzip

curl -o pa_src.zip https://app.assembla.com/spaces/portaudio-hotplug-coreaudio-2016/git/source/hotplug?_format=zip
unzip -d src pa_src.zip || exit 1

cd src
mkdir cmake_build
cd cmake_build
CC=clang CXX=clang++ cmake -Wno-dev -Wno-deprecated ..
make -j$(nproc)

cd ../..
cp src/cmake_build/libportaudio.so ./ || exit 1

clang test.c -DLIBNAME=\"./libportaudio.so\" -o test -ldl
./test

rm -rf src pa_src.zip test

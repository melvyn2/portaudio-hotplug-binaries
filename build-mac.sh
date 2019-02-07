#!/bin/bash

curl -o pa_src.zip https://app.assembla.com/spaces/portaudio-hotplug-coreaudio-2016/git/source/hotplug?_format=zip
unzip -d src pa_src.zip

cd src
CC=clang CXX=clang++ ./configure --disable-debug --disable-dependency-tracking --enable-mac-universal=no --disable-cxx
sed -i -e 's/global_symbol_pipe=""/global_symbol_pipe="cat"/g' libtool
make

cd ..
cp src/lib/.libs/libportaudio.2.dylib ./libportaudio.dylib

rm -rf src pa_src.zip

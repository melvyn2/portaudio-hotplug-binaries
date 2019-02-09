#!/bin/bash

curl -o pa_src.zip https://app.assembla.com/spaces/portaudio/git/source/hotplug?_format=zip
unzip -d src pa_src.zip

cd src
CC=clang CXX=clang++ ./configure --disable-debug --disable-dependency-tracking --disable-cxx
make

cd ..
cp src/lib/.libs/libportaudio.so.2.0.0 ./libportaudio.so

rm -rf src pa_src.zip

#!/bin/bash

set -ex

pushd GKlib

mkdir build
mkdir static-libs

pushd build

cmake ${CMAKE_ARGS} \
      -DCMAKE_PREFIX_PATH=${PREFIX} \
      -DCMAKE_INSTALL_PREFIX=../static-libs \
      -DDEBUG=OFF \
      -DOPENMP=set \
      -DBUILD_SHARED_LIBS=OFF \
      ..

cmake --build . --config Release
cmake --install .

popd

popd

make config \
     shared=1 \
     gklib_path=GKlib/static-libs \
     prefix=$PREFIX

make
make install

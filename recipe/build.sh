#!/bin/bash

# Build dynamic libs
make config shared=1 prefix=$PREFIX
make
make install

# Build static libs
make config prefix=$PREFIX
make
make install

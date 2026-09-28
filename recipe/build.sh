#!/bin/bash

export CMAKE_POLICY_VERSION_MINIMUM=3.5

make config \
     shared=1 \
     prefix=$PREFIX

make
make install

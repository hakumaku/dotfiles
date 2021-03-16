#! /usr/bin/env bash

sudo apt install libc6-dev-i386
git clone https://github.com/milaq/libstrangle &&
	(cd libstrangle && make && sudo make install)

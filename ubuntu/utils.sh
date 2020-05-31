#!/usr/bin/env bash

sudo apt install cargo llvm libclang-dev &&
	cargo install --locked exa fd-find bat

#!/usr/bin/env bash

files=$(fd -e 'lua')
for file in ${files[@]}; do
	echo $file
	lua-format --config=.lua-format -i $file
done

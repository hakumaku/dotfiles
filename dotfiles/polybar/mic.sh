#!/usr/bin/env bash
mic=($( amixer sget Capture | awk 'NR == 5 { print $5,$6 }' | tr -d '[]' ))
if [[ "${mic[1]}" = "on" ]]; then
	printf " %4s" ${mic[0]}
else
	printf " %4s" ${mic[0]}
fi

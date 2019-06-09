#!/usr/bin/env bash

if [ $( systemctl is-active bluetooth.service ) == "active" ]; then
	  echo ""
else
	  echo ""
fi


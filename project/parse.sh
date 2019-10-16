#!/usr/bin/env bash
grep -m 1 -o '"todaytemp">[0-9]*</span>' /home/pi/project/weather.log | head -1

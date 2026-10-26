#!/bin/bash

isRunning=$(ps h -fC btop)

if [ ${#isRunning} != 0 ]; then
	pkill btop
else
	alacritty -t "btop" -e btop

fi

#!/bin/bash

isRunning=$(ps h -fC rmpc)

if [ ${#isRunning} != 0 ]; then
	pkill rmpc
else
	alacritty -t "Music Player" -e rmpc
fi

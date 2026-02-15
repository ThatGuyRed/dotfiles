#!/bin/bash

isRunning=$(ps h -fC calcurse)

if [ ${#isRunning} != 0 ]; then
	pkill calcurse
else
	alacritty -T "Calcurse" -e calcurse
fi

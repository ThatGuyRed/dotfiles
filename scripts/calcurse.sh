#!/bin/bash

isRunning=$(ps h -fC calcurse)

if [ ${#isRunning} != 0 ]; then
	pkill calcurse
else
	alacritty -t "Calcurse" -e calcurse

fi

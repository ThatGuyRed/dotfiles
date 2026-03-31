#!/bin/bash

isRunning=$(ps h -fC bluetuith)

if [ ${#isRunning} != 0 ]; then
	pkill bluetuith
else
	alacritty -T 'Bluetooth Control' -e bluetuith
fi

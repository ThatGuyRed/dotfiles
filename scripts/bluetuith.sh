#!/bin/bash

isRunning=$(ps h -fC bluetuith)

if [ ${#isRunning} != 0 ]; then
	pkill bluetuith
else
	foot -T 'Bluetooth Control' -e bluetuith
fi

#!/bin/bash

isRunning=$(ps h -fC nmtui)

if [ ${#isRunning} != 0 ]; then
	pkill nmtui
else
	foot -T "Network Manager" -e nmtui
fi

#!/bin/bash

isRunning=$(ps h -fC pavucontrol)

if [ ${#isRunning} != 0 ]; then
	pkill pavucontrol
else
	pavucontrol
fi

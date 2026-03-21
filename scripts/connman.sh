#!/bin/bash

isRunning=$(ps h -fC connman-gtk)

if [ ${#isRunning} != 0 ]; then
	pkill connman-gtk
else
	connman-gtk
fi

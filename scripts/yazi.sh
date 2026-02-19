#!/bin/bash

isRunning=$(ps h -fC yazi)

if [ ${#isRunning} != 0 ]; then
	pkill yazi
else
	foot -T "Yazi Sidebar" -e yazi "~/Documents/sync/QUT/2026 Semester 1"

      

fi

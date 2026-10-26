#!/bin/bash

COMMAND=$1

if [[ "$COMMAND" == "up" ]]; then
	tailscale up --accept-routes --operator=red
	sudo mount -a
elif [[ "$COMMAND" == "down" ]]; then
	tailscale down
else
	echo "Unknown command"
fi



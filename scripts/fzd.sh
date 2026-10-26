#!/bin/bash
DIR=""
cd ~/Documents/sync/
#DIR=$(fd -t d | fzf)
cd "$(fd -t d | fzf)"
setsid -f alacritty 

#!/bin/bash

WORKING_DIR=$1 # Sets first parameter as working dir / file
SESSION_NAME="Tmux-nvim"
QUOTE="'"

cd $WORKING_DIR

#CMD="nvim ${WORKING_DIR}"
# Source tmux config
tmux source-file ~/.config/tmux.conf

# Create a new session and name it
tmux new-session -d
# Change to working directory

# Split windows
tmux split-window -v
tmux resize-pane -D -t 0 -y 110 # Resizes Pane 1

# Send a command to the first pane
#tmux send-keys -t 0 'cd $WORKING_DIR' C-m
#tmux send-keys -t 1 'cd $WORKING_DIR' C-m
tmux send-keys -t 0 "nvim $QUOTE$WORKING_DIR$QUOTE" C-m

# Attach to the created session
tmux attach-session

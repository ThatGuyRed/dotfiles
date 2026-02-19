#!/bin/bash

SESSION_NAME="TMUX-IDE"
WORKING_DIR=$1 # Sets first parameter as working dir

# Check if the session already exists
if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "Session $SESSION_NAME already exists. Attaching to it."
    tmux attach-session -t $SESSION_NAME
else
    # Create a new session and name it
    tmux new-session -d -s $SESSION_NAME

    # Split windows
    tmux split-window -h
    tmux resize-pane -L -t 0 -x 15 # Resizes Pane 0
    tmux split-window -v -t 1 #"~/Documents" #Uncomment to select folder
    tmux resize-pane -D -t 1 -y 95 # Resizes Pane 1

    # Send a command to the first pane
    tmux send-keys -t 0 'yazi ~/Documents/sync' C-m

    # Send a command to the second pane
    tmux send-keys -t 1 'nvim' C-m

    # Split second pane and resize
        
    # Attach to the created session
    tmux attach-session -t $SESSION_NAME
fi

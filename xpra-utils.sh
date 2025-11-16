#!/bin/bash

# XPRA Utility Functions for tmux
# Source this file in your shell: source ~/.config/tmux/xpra-utils.sh

# Function to start XPRA server in tmux
start_xpra_server() {
    local display=${1:-100}
    local port=${2:-10000}
    
    tmux new-session -d -s "xpra-server-${display}" \
        "xpra start :${display} --daemon=no --bind-tcp=0.0.0.0:${port} --html=on --start-child=xterm"
    
    echo "XPRA server started on display :${display}, port ${port}"
    echo "Connect with: xpra attach tcp://localhost:${port}"
}

# Function to start GUI app in existing XPRA session
start_xpra_app() {
    local app=${1:-xterm}
    local display=${2:-100}
    
    xpra control :${display} start-child "${app}"
    echo "Started ${app} on display :${display}"
}

# Function to list running XPRA servers
list_xpra() {
    xpra list || echo "No XPRA servers running"
}

# Function to stop XPRA server
stop_xpra() {
    local display=${1:-100}
    xpra stop :${display}
    tmux kill-session -t "xpra-server-${display}" 2>/dev/null
    echo "Stopped XPRA server on display :${display}"
}

# Function to create a complete XPRA development environment
setup_xpra_dev() {
    local session_name=${1:-xpra-dev}
    local display=${2:-100}
    local port=${3:-10000}
    
    # Create tmux session with multiple windows
    tmux new-session -d -s "${session_name}"
    
    # Window 0: XPRA server
    tmux rename-window -t "${session_name}:0" "server"
    tmux send-keys -t "${session_name}:0" "xpra start :${display} --daemon=no --bind-tcp=0.0.0.0:${port} --html=on" C-m
    
    # Window 1: Control terminal
    tmux new-window -t "${session_name}" -n "control"
    tmux send-keys -t "${session_name}:control" "sleep 3" C-m
    tmux send-keys -t "${session_name}:control" "echo 'XPRA Control Terminal'" C-m
    tmux send-keys -t "${session_name}:control" "echo 'Start apps with: xpra control :${display} start-child <app>'" C-m
    
    # Window 2: Client monitor
    tmux new-window -t "${session_name}" -n "monitor"
    tmux send-keys -t "${session_name}:monitor" "sleep 5" C-m
    tmux send-keys -t "${session_name}:monitor" "xpra info :${display}" C-m
    
    # Attach to session
    tmux attach-session -t "${session_name}"
}

# Export functions
export -f start_xpra_server
export -f start_xpra_app
export -f list_xpra
export -f stop_xpra
export -f setup_xpra_dev

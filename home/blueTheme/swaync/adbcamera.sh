#!/bin/bash

# Configuration file to store IP and port
CONFIG_FILE="$HOME/.scrcpy_config"

# Check if the configuration file exists
if [ -f "$CONFIG_FILE" ]; then
    # Source the configuration file to load IP and port
    source "$CONFIG_FILE"
else
    echo "Configuration file not found. Please run the main script to set up the IP and port."
    exit 1
fi

# Command to enable camera streaming via scrcpy
scrcpy --tcpip="$ip:$port" --video-source=camera --camera-size=1920x1080 --v4l2-sink=/dev/video1 --no-video-playback --v4l2-buffer=50

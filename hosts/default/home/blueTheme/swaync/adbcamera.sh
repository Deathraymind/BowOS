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

# Ask the user if the connection is wired or wireless
echo -n "Is the connection wired? (y/n): "
read is_wired

# If the connection is wired
if [ "$is_wired" == "y" ]; then
    # Run the scrcpy command without the TCP/IP option
    scrcpy --video-source=camera --camera-size=1920x1080 --v4l2-sink=/dev/video1 --no-video-playback --v4l2-buffer=50
else
    # Run the scrcpy command using the stored IP and port for wireless connection
    scrcpy --tcpip="$ip:$port" --video-source=camera --camera-size=1920x1080 --v4l2-sink=/dev/video1 --no-video-playback --v4l2-buffer=50
fi

# Check if scrcpy was successful
if [ $? -eq 0 ]; then
    echo "Successfully started camera streaming."
else
    echo "Failed to start camera streaming. Please check your setup."
fi
#!/bin/bash

# Configuration file to store IP and port
CONFIG_FILE="$HOME/.scrcpy_config"

# Function to ask if the user wants to change IP and port
ask_for_change() {
    echo -n "Do you want to change the IP address and port? (y/n): "
    read change
    if [ "$change" != "y" ]; then
        return 1
    fi
    return 0
}

# Function to ask if the connection is wired or wireless
ask_for_connection_type() {
    echo -n "Is the connection wired? (y/n): "
    read is_wired
    if [ "$is_wired" == "y" ]; then
        return 0  # Wired connection
    else
        return 1  # Wireless connection
    fi
}

# Check if configuration file exists
if [ -f "$CONFIG_FILE" ]; then
    # Source the configuration file to load IP and port
    source "$CONFIG_FILE"
    echo "Current IP address: $ip"
    echo "Current port: $port"

    # Ask if the user wants to change IP and port
    if ask_for_change; then
        # Prompt the user for new IP address and port
        echo -n "Please enter the new IP address: "
        read ip

        echo -n "Please enter the new port number: "
        read port

        # Save the new IP and port to the configuration file
        echo "ip=\"$ip\"" > "$CONFIG_FILE"
        echo "port=\"$port\"" >> "$CONFIG_FILE"
    fi
else
    # Prompt the user for IP address and port if config file doesn't exist
    echo "Please go to the Wireless Debugging options on your Android phone and locate the IP address and port."
    echo -n "Please enter the IP address: "
    read ip

    echo -n "Please enter the port number: "
    read port

    # Save the IP and port to the configuration file
    echo "ip=\"$ip\"" > "$CONFIG_FILE"
    echo "port=\"$port\"" >> "$CONFIG_FILE"
fi

# Clear the screen
clear

# Ask the user if the connection is wired or wireless
if ask_for_connection_type; then
    # Run the scrcpy command without the TCP/IP option for wired connection
    scrcpy
else
    # Run the scrcpy command using the stored IP and port for wireless connection
    scrcpy --tcpip="$ip:$port"
fi

# Check if scrcpy was successful
if [ $? -eq 0 ]; then
    echo "Successfully connected to the device using scrcpy."
else
    echo "Failed to connect to the device. Please check your setup."
fi
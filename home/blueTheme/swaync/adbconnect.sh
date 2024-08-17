#!/bin/bash

# Prompt the user to enable wireless debugging and find the IP and port
echo "Please go to the Wireless Debugging options on your Android phone and locate the IP address and port."
echo -n "Please enter the IP address: "
read ip

# Clear the screen
clear

# Prompt the user for the port number
echo -n "Please enter the port number: "
read port

# Clear the screen
clear

# Attempt to connect using scrcpy over TCP/IP
scrcpy --tcpip="$ip:$port"
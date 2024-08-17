#!/bin/bash

# Prompt the user to enable wireless debugging on their Android phone
echo "Please open up Developer Options and enable Wireless Debugging on your Android phone."
echo "Look for the 'Pair with code' option. Ensure both this computer and the phone are on the same network!"

# Ask for the IP address
echo -n "Please enter the IP address: "
read ip

# Clear the screen
clear

# Ask for the port number
echo -n "Please enter the port number: "
read port

# Clear the screen
clear

# Pair the device using the provided IP and port
adb pair "$ip:$port"
#!/bin/bash
echo "Please open up Developer Options and enable Wireless Debugging on your Android phone."
echo "Look for the 'Pair with code' option. Ensure both this computer and the phone are on the same network!"
echo -n "Please enter the IP address: "
read ip
clear
echo -n "Please enter the port number: "
read port
clear
adb pair "$ip:$port"
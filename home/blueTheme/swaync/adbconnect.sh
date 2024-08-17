#!/bin/bash
echo "Please open up developer wireless debuging on youre android phone and look for pair with code. Be sure both this computer and phone are on the same network!"
echo "Please enter the IP"
read ip
clear
echo "Please enter port"
read port
clear

adb pair $ip:$port 

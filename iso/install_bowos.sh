#!/bin/bash

# Ensure we are running as root
git clone --branch beta https://github.com/deathraymind/BowOS 
cd BowOS 
nix-shell --run '
python3 disk_formatter.py
'

#!/bin/bash

# Ensure we are running as root
rm -r BowOS
git clone --branch nvidia-fix https://github.com/deathraymind/BowOS 
cd BowOS 
nix-shell --run '
python3 disk_formatter.py
'

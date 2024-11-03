#!/bin/bash
sudo mkdir /run/systemd/system/nix-daemon.service.d/
cat << EOF | sudo tee /run/systemd/system/nix-daemon.service.d/override.conf
[Service]
Environment="http_proxy=socks5h://192.168.49.1:8000"
Environment="https_proxy=socks5h://192.168.49.1:8000"
Environment="all_proxy=socks5h://192.168.49.1:8000"
EOF

sudo systemctl daemon-reload

sudo systemctl restart nix-daemon



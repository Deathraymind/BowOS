env BOWOS_USER="$BOWOS_USER" BOWOS_PASSWORD="$BOWOS_PASSWORD" nixos-enter -- nix-shell -p expect --extra-experimental-features flakes --run bash <<EOF
# Create the user
useradd -m "\$BOWOS_USER"

# Set the password for the new user using expect
expect -c "
  spawn passwd \$BOWOS_USER
  expect \"New password:\"
  send \"\$BOWOS_PASSWORD\r\"
  expect \"Retype new password:\"
  send \"\$BOWOS_PASSWORD\r\"
  expect eof
"

# Set the password for root using expect
echo $BOWOS_PASSWORD
expect -c "
  spawn passwd root
  expect \"New password:\"
  send \"\$BOWOS_PASSWORD\r\"
  expect \"Retype new password:\"
  send \"\$BOWOS_PASSWORD\r\"
  expect eof
"
EOF


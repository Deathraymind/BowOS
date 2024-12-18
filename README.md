# BowOS Installation Guide

![image](https://github.com/user-attachments/assets/04a76591-0e72-49a1-8c80-d49fee72631e)



1. **Download the ISO**
   - Download the BowOS ISO [here](#).

2. **Flash the ISO**
   - Use the `dd` command
   ```
   sudo dd bs=4M if=bowos-x86_64-linux.iso of=/dev/sda status=progress oflag=sync
   ```
   - Replace sda with your usb drive use lsblk to see the usb drive. 
   - or Balena Etcher to flash the ISO to a USB stick.  
     - Download Balena Etcher from [https://etcher.balena.io/](https://etcher.balena.io/).

3. **Boot from USB**
   - Insert the USB drive into your computer.
   - Spam **F12**, **F9**, or **Delete** to access the boot menu.  
     **Note:** BIOS systems are currently not supported by BowOS.

4. **Starting the Installer**
   - After booting, you'll see a screen after the standard NixOS messages.
   - Run the installer as root:
     ```bash
     sudo passwd root
     ```
     - Set your root password.  
     - Switch to the root user:
       ```bash
       su root
       ```

5. **Run the Installation Script**
   - Navigate to `/etc`:
     ```bash
     cd /etc
     ```
   - Run the installation script:
     ```bash
     bash install-bowos.sh
     ```
   - The script will fetch the installer from GitHub and start a Python-based installation interface.

6. **Select and Format the Disk**
   - WARNING: The selected drive will be **completely wiped**.
   - Identify the disk to format, e.g., `/dev/sda`. Ensure you select the correct drive as there’s no way to undo this step.

   - Use the **Tab** key to move between fields in the installer. Enter your username and password as prompted.

7. **Installation Process**
   - The installation will download ~2GB of packages from the internet and install ~11GB of packages from the USB drive.  
   - Installation time varies:
     - Old hardware: ~20 minutes.
     - Favorable conditions: as little as 8 minutes.

8. **Post-Installation**
   - After installation, reboot your system. BowOS should now be ready to use.

### Notes
- **Beta Status:** BowOS is in beta. Updating the system and retaining installed applications is currently challenging.
- **Recommendation:** If using BowOS to learn NixOS, read the official NixOS documentation and customize the code as needed.
- Tools will be released in the future to make NixOS more accessible as the project evolves.

**IMPORTANT:** Use `lsblk` to list drives and ensure you select the correct one before proceeding.

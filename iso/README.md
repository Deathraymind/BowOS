   # to build the os run
    # sudo dd bs=4M if=result/iso/nixos-25.05.19700101.dirty-x86_64-linux.iso of=/dev/sdX status=progress oflag=sync
    #  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=./iso.nix
    # nix build .#nixosConfigurations.bowos.config.system.build.isoImage --impure
    # to creat a .nar file with all the goofy files use this 
    # nix-store -qR /run/current-system > installed-packages.txt
    # sed -i '/dbus/d' installed-packages.txt 
    # nix-store --export $(cat installed-packages.txt) > bowos-packages.nar
    # scp root@192.168.122.53:/mnt/all-installed-packages.nar /home/bowyn/BowOSv0.01/iso
    # Provide an initial copy of the NixOS channel so that the user
    # nix-store --import < /path/to/your.nar --store /mnt/nix/store

    # doesn't need to run "nix-channel --update" first.

This is the BowOS ISO generation tools 

this is built using a flake and a configuration file, flake.nix and iso.nix respectably.

To build the ISO as is you sould be able to run the command


```bash 
nix build .#nixosConfigurations.bowos.config.system.build.isoImage --impure
```

this will place a iso in the ./result/iso directory. 

to flash this iso on a usb stick we can use the dd command here is an example of such below.


```bash 
sudo dd bs=4M if=result/iso/nixos-25.05.19700101.dirty-x86_64-linux.iso of=/dev/sdX status=progress oflag=sync
```

replace the name with the iso gernation name, and sdx with the correct usb drive you can find the disk name with the lsblk command.


This iso acts as a normal iso basically but with some extra configs defined such as the packages installed.


now the installer scripts, diskformatter_py and disk_formatter.sh is a series of scirpts to download and pull the conifgs from the repo. 

The main thing is you can set user and password, and it will package all the defined packages in configuragtion.nix and transfer them to the new install drive. It does this with the command.

These commands create the .nar file in the /mnt/tmp directory aka the installed BowOS drive.
```bash 
mkdir -p /mnt/tmp
nix-store -qR /run/current-system > installed-packages.txt
nix-store --export $(cat installed-packages.txt) > /mnt/tmp/bowos-packages.nar
```

Later the script will enter the drive nixos-enter and unpack the .nar file.

```bash 
nix-store --import < /tmp/bowos-packages.nar
```

This saves all the packages from be redownloaded from the internet but is more cpu intensive and can be way slower on older machines but it works really well. Why the nixos-install command dosnt copy the packages from the iso, idk..

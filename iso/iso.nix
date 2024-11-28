{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    # to build the os run
    #  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=./iso.nix
    # to creat a .nar file with all the goofy files use this 
    # nix-store -qR /run/current-system > installed-packages.txt 
    # nix-store --export $(cat installed-packages.txt) > bowos-packages.nar
    # scp root@192.168.122.53:/mnt/all-installed-packages.nar /home/bowyn/BowOSv0.01/iso
    # nix-store --export $(nix-store -qR /run/current-system) > system-packages.nar
    # Provide an initial copy of the NixOS channel so that the user
    # nix-store --import < /path/to/your.nar --store /mnt/nix/store

    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    <nixpkgs/nixos/modules/system/etc/etc.nix>
  ];

    environment.systemPackages = with pkgs; [
      # Include all your packages here
      neovim
      git
      kitty
      ethtool
      pciutils
      usbutils
      pamixer
      networkmanager
      networkmanagerapplet
      brightnessctl
      imagemagick
      ffmpegthumbs
      nwg-look
      pipewire
      htop
      dconf
      glib
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      python3
      python3Packages.textual


    ];





    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix for the types of fonts
    isoImage.squashfsCompression = "gzip -Xcompression-level 1";
    environment.etc."install_bowos.sh".source = /home/bowyn/BowOSv0.01/iso/install_bowos.sh;
    environment.etc."prox.sh".source = /home/bowyn/BowOSv0.01/iso/prox.sh;
    environment.etc."bowos-packages.nar".source = /home/bowyn/BowOSv0.01/iso/bowos-packages.nar;

    


    services.openssh.enable = true; # enables the sshd server on the computer 
    services.openssh.permitRootLogin = "yes";  # // or "no" if you want to disable root login
    services.openssh.passwordAuthentication = true; # // or false to disable password authentication
}

{ config, pkgs, lib, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    # to build the os run
    #  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=./iso.nix
    # to creat a .nar file with all the goofy files use this 
    # nix-store -qR /run/current-system > installed-packages.txt
    # sed -i '/dbus/d' installed-packages.txt 
    # nix-store --export $(cat installed-packages.txt) > bowos-packages.nar
    # scp root@192.168.122.53:/mnt/all-installed-packages.nar /home/bowyn/BowOSv0.01/iso
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

      environment.etc."issue".text = ''
\e[34m
.--------------------------------------------.
|██████╗  ██████╗ ██╗    ██╗ ██████╗ ███████╗|
|██╔══██╗██╔═══██╗██║    ██║██╔═══██╗██╔════╝|
|██████╔╝██║   ██║██║ █╗ ██║██║   ██║███████╗|
|██╔══██╗██║   ██║██║███╗██║██║   ██║╚════██║|
|██████╔╝╚██████╔╝╚███╔███╔╝╚██████╔╝███████║|
|╚═════╝  ╚═════╝  ╚══╝╚══╝  ╚═════╝ ╚══════╝|
'--------------------------------------------'
Welcome to BowOS
\e[0m

\e[34mSteps to install:\e[0m
\e[34m1. Set a root password:\e[0m
   \e[34msudo passwd root\e[0m
\e[34m2. Navigate to the /etc directory:\e[0m
   \e[34mcd /etc\e[0m
\e[34m3. Run the installation script:\e[0m
   \e[34mbash install-bowos.sh\e[0m
'';


  boot.loader.grub = lib.mkForce {
    enable = true;
    device = "nodev"; # Required for ISO image builds
    extraConfig = ''
      set menu_color_normal=white/black
      set menu_color_highlight=black/white
      echo "Custom Banner: Welcome to the BowOS Installer"
    '';
  };


    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix for the types of fonts
    isoImage.squashfsCompression = "gzip -Xcompression-level 1";
    environment.etc."install_bowos.sh".source = ./install_bowos.sh;
    environment.etc."bowos-packages.nar".source = ./bowos-packages.nar;
    system.build.isoImage.isoName = "bowos-x86-v1.0.1";
    


    services.openssh.enable = true; # enables the sshd server on the computer 
    services.openssh.permitRootLogin = "yes";  # // or "no" if you want to disable root login
    services.openssh.passwordAuthentication = true; # // or false to disable password authentication
}
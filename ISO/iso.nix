{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    # to build the os run
    #  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=./iso.nix
    # to creat a .nar file with all the goofy files use this 
    # nix-store -qR /run/current-system > installed-packages.txt 
    # nix-store --export $(cat installed-packages.txt) > all-installed-packages.nar

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

    environment.systemPackages = with pkgs; [
      # Include all your packages here
      neovim
      git
      kitty
      waybar
      rofi
      ethtool
      gnome.nautilus
      wl-clipboard
      pciutils
      usbutils
      pipewire
      pamixer
      networkmanager
      networkmanagerapplet
      bluez
      blueman
      brightnessctl
      playerctl
      dunst
      swaynotificationcenter
      grim
      slurp
      swappy
      cliphist
      hyprpicker
      polkit-kde-agent
      xdg-desktop-portal-hyprland
      imagemagick
      ffmpegthumbs
      nwg-look
      qt5ct
      qt6ct
      gtk4
      gtk3
      hyprland
      hyprpaper
      fastfetch
      hyprlock
      pavucontrol
      pipewire
      xorg.xrandr
      home-manager
      htop
      playerctl
      dconf
      glib
      gnome.gnome-disk-utility
      udisks2
      firefox
      python3
      python3Packages.pytorch
      pipewire
      wireplumber
      scrcpy
      android-tools
      gcc
      cpufrequtils
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      python3
      python3Packages.textual

    ];
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix for the types of fonts
    isoImage.squashfsCompression = "gzip -Xcompression-level 1";

    environment.etc."install_bowos.sh".source = /home/bowyn/BowOSv0.01/install_bowos.sh;
}

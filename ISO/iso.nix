{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    
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
      nerdfonts
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
      jdk
    ];
    


}


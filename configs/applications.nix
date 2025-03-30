# applications.nix 
# A configuration file for apps
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obs-studio
    gcc
    wl-color-picker
    neovim
    git
    waybar
    rofi
    ethtool
    gnome.nautilus
    vlc
    wl-clipboard
    libva
    lazygit
    
    # Terminal
    zsh
    starship
    kitty
    
    # Audio
    pipewire
    pamixer
    
    # Network
    networkmanager
    networkmanagerapplet
    
    # Bluetooth
    bluez
    blueman
    
    brightnessctl
    playerctl
    swaynotificationcenter
    
    # Screenshot
    grim
    slurp
    swappy
    cliphist
    hyprpicker
    
    # Dependencies
    polkit-kde-agent
    xdg-desktop-portal-hyprland
    jq
    imagemagick
    ffmpegthumbs
    
    # Theme stuff
    hyprpaper
    fastfetch
    hyprlock
    pavucontrol
    xorg.xrandr
    home-manager
    htop
    dconf
    glib
    
    # Virtual Machine
    qemu
    gnome.gnome-disk-utility
    udisks2
    firefox
    polkit
    lxqt.lxqt-policykit
    ranger
    
    # Screen Sharing
    pipewire
    wireplumber
    
    # Phone Sync
    scrcpy
    
    obsidian
    helvum
  ];

  }


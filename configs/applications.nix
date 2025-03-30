# applications.nix 
# A configuration file for apps
{ pkgs, ...}:
{

environment.systemPackages = with pkgs; [
    obs-studio
  #  krita
  #  alvr
  #  expressvpn
  #  blender
    gcc
  #  libsForQt5.qtstyleplugin-kvantum
  #  libsForQt5.qt5ct
  #  libsForQt5.qtstyleplugins
  #  qt5.qtbase
  #  adwaita-qt
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
  #  # Terminal
    zsh
    starship
  #  fzf
    kitty
  #  alacritty
  #  # audio
    pipewire
    pamixer
  #  # network
    networkmanager
    networkmanagerapplet
  #  # bluetooth
    bluez
    blueman
    brightnessctl
    playerctl
    swaynotificationcenter

  #  # screenshot
    grim
    slurp
  #  arduino-ide
    swappy
    cliphist
    hyprpicker

  #  ydotool

  #  # dependencies
    polkit-kde-agent
    xdg-desktop-portal-hyprland
    jq
    imagemagick
    ffmpegthumbs

  #  # theme stuff
  #  nwg-look
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
  #  # Virtual Machine
    qemu
    gnome.gnome-disk-utility
    udisks2
    firefox
    polkit
    lxqt.lxqt-policykit
    ranger
  #  # Screen Sharing
    pipewire
    wireplumber
  #  # Phone Sync
    scrcpy
  #  v4l2-relayd
  #  v4l-utils
  #  android-tools
  #  cpufrequtils
  #  libsForQt5.qtstyleplugin-kvantum
  #  libsForQt5.qt5ct
    obsidian
    helvum
];

services = {
  udisks2.enable = true;
  dbus.enable = true;
  # SSH
  openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "no";
  services.gvfs.enable = true;
  #programs.kdeconnect.enable = true;
  #services.flatpak.enable = true;
  services.blueman.enable = true;

};

services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  };

programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

programs.virt-manager.enable = true;
virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };


hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    };
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC = 1;
      CPU_MAX_PERF_ON_AC = 95;
      CPU_MAX_PERF_ON_BAT = 30;
    };
  };






}





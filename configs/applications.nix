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

  services = {
    udisks2.enable = true;
    dbus.enable = true;
    
    # SSH
    openssh.enable = true;
    services.openssh.passwordAuthentication = true;
    services.openssh.permitRootLogin = "no";
    
    services.gvfs.enable = true;
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
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
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


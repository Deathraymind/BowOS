# configuration.nix
{ config, pkgs, inputs, lib, ... }:



{
  imports =
    [ 
      (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master") # this includes the nix os vs code server. 
      
      /etc/nixos/hardware-configuration.nix # Include the results of the hardware scan.
      
    ];


   

# run these two commands
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
# sudo nix-channel --update
# append unstable. to the package you want to pull from the unstable channel
nixpkgs.config.packageOverrides = pkgs: {
    unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
    };
};


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant. 

  # Configure w network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bowyn = {
    isNormalUser = true;
    description = "bowyn";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };



# ____            _    _              
#|  _ \  ___  ___| | _| |_ ___  _ __  
#| | | |/ _ \/ __| |/ / __/ _ \| '_ \ 
#| |_| |  __/\__ \   <| || (_) | |_) |
#|____/ \___||___/_|\_\\__\___/| .__/ 
#                              |_|      

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };

#__            _                         
#|  _ \ __ _  ___| | ____ _  __ _  ___  ___ 
#| |_) / _` |/ __| |/ / _` |/ _` |/ _ \/ __|
#|  __/ (_| | (__|   < (_| | (_| |  __/\__ \
#|_|   \__,_|\___|_|\_\__,_|\__, |\___||___/
#                           |___/           

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    kitty
    vscode
    waybar
    rofi
    nerdfonts
    ethtool
    gnome.nautilus
    libsForQt5.filelight

    pciutils # lspci
    usbutils # lsusb

    # audio
    pipewire
    pamixer

    # network
    networkmanager
    networkmanagerapplet

    # bluetooth
    bluez
    blueman

    brightnessctl

    # dunst # this is the notification daemon.
    swaynotificationcenter

    # screenshot
    grim
    slurp
    swappy
    cliphist
    hyprpicker

    # dependencies
    polkit-kde-agent
    xdg-desktop-portal-hyprland
    parallel
    jq
    imagemagick
    ffmpegthumbs
    kde-cli-tools

    # theme stuff
    nwg-look
    qt5ct
    qt6ct
    gtk4
    gtk3

    hyprland 
    hyprpaper
    fastfetch
    unstable.hyprlock # The unstable. is pulled from the unstable channel of NixOS
    pavucontrol 
    pipewire
    steam
    xorg.xrandr
    obs-studio
    appimage-run
    flatpak
    unstable.alvr
    home-manager
    htop
    playerctl
    flatpak
    dconf
    glib
    

    # Virtual Machine
    qemu

    discord
    unstable.r2modman
    flatpak
    prismlauncher
    gnome.gnome-terminal
    gnome.gnome-disk-utility
    udisks2
    cava
    obsidian
    firefox
    whatsapp-for-linux

    # Pytorch/Skynet
    # python3
    # python3
    # python3Packages.pytorch

    remmina

    polkit
    lxqt.lxqt-policykit

    krita
    cura

    expressvpn

    kdePackages.kdeconnect-kde

    obs-studio

    ranger
  ];



  fonts.fonts = with pkgs; [
     nerdfonts # this pulls the nerdfonts from the nixos and makes it available. 
  ];

# ____                  _      _           
#/ ___|  ___ _ ____   _(_) ___(_) ___  ___ 
#\___ \ / _ \ '__\ \ / / |/ __| |/ _ \/ __|
# ___) |  __/ |   \ V /| | (__| |  __/\__ \
#|____/ \___|_|    \_/ |_|\___|_|\___||___/

  programs.kdeconnect.enable = true; 
  
  services.udisks2.enable = true; 
  security.polkit.enable = true;
  services.expressvpn.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true; # enables the sshd server on the computer
  services.vscode-server.enable = true; # this enables the vs code server.
  
  services.openssh.permitRootLogin = "yes";  # // or "no" if you want to disable root login
  services.openssh.passwordAuthentication = true; # // or false to disable password authentication

  # Steam

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; 
 
  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["amdgpu"];

  # Enable networking
  networking.networkmanager.enable = true; # Enables dhcp and ethernet support IMPORTANT

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

# _____ _                        _ _ 
#|  ___(_)_ __ _____      ____ _| | |
#| |_  | | '__/ _ \ \ /\ / / _` | | |
#|  _| | | | |  __/\ V  V / (_| | | |
#|_|   |_|_|  \___| \_/\_/ \__,_|_|_|

networking.firewall = {
  enable = true; # Make sure the firewall is enabled
  
  allowedTCPPorts = [ 9943 9944 51112 ]; # List of TCP ports to open
  allowedUDPPorts = [ 9943 9944 51112 ]; # List of UDP ports to open, if needed
  allowedTCPPortRanges = [  { from = 1714; to = 1764; }]; # List of TCP ports to open
  allowedUDPPortRanges = [  { from = 1714; to = 1764; }]; # List of UDP ports to open, if needed
 
};


# Virtual Machines

virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

  
  nixpkgs.config.permittedInsecurePackages = [
 "electron-25.9.0"
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # this is a nixos experimental feature called flakes
  system.stateVersion = "24.05"; # Did you read the comment? tahdah
}

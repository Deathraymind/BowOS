# configuration.nix
{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ 
      
            # ./stylix.nix
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


  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Phone Camera
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" "acpi-cpufreq" ];

  boot.extraModprobeConfig = ''
  options v4l2loopback video_nr=1 card_label="VirtualCam" exclusive_caps=1
  '';
  # Run this command to run the virtual camera
  # scrcpy --video-source=camera --camera-size=1920x1080 --v4l2-sink=/dev/video1 --no-video-playback --v4l2-buffer=50
 time.timeZone = lib.mkDefault "Asia/Tokyo"; 
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant. 

  # Configure w network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# Set your time zone. time.timeZone = "Asia/Tokyo"; Select internationalisation properties. i18n.defaultLocale = "en_US.UTF-8";

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

    gnupg 
    pinentry
    direnv
    cargo-tauri
    rustup

    vscode
    rustup
    blender
    wl-color-picker
    nodePackages.browser-sync
    neovim
    git
    kitty
    waybar
    librepcb
    rofi
    nerdfonts
    ethtool
    gnome.nautilus
    libsForQt5.filelight
    vlc
    wl-clipboard
    checkra1n
    btop
# test
    pciutils # lspci
    usbutils # lsusb
    libva
    lazygit
    # audio
    pipewire
    pamixer
    logseq
    # network
    networkmanager
    networkmanagerapplet

    # bluetooth
    bluez
    blueman

    brightnessctl
    playerctl
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
    home-manager
    htop
    playerctl
    dconf
    glib
    

    # Virtual Machine
    qemu

    unstable.r2modman
    flatpak
    prismlauncher
    gnome.gnome-terminal
    gnome.gnome-disk-utility
    udisks2
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

    expressvpn

    kdePackages.kdeconnect-kde

    obs-studio

    ranger

    # Screen Sharing
    pipewire
    wireplumber

    # Phone Sync
    scrcpy
    v4l2-relayd
    v4l-utils
    localsend
    android-tools
    teamviewer
    woeusb-ng

    virtualboxKvm

    spicetify-cli
    gcc
    cpufrequtils 
    vencord
    vesktop

    jdk
    nerdfonts
  ];


fonts.packages = with pkgs; [
        nerdfonts
];


# ____                  _      _           
#/ ___|  ___ _ ____   _(_) ___(_) ___  ___ 
#\___ \ / _ \ '__\ \ / / |/ __| |/ _ \/ __|
# ___) |  __/ |   \ V /| | (__| |  __/\__ \
#|____/ \___|_|    \_/ |_|\___|_|\___||___/


stylix.image = /home/bowyn/bowos/wallpaper/wallpapers/wp.png;
  programs.kdeconnect.enable = true; 
  services.udisks2.enable = true; 
  security.polkit.enable = true;
  services.expressvpn.enable = true;
  services.flatpak.enable = true;
  services.openssh.enable = true; # enables the sshd server on the computer


# power saving
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_BOOST_ON_BAT=0;
      CPU_BOOST_ON_AC=1;
      
        #CPU_SCALING_GOVERNOR_ON_AC="powersave";

      # The following prevents the battery from charging fully to
      # preserve lifetime. Run `tlp fullcharge` to temporarily force
      # full charge.
      # https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds

      # 100 being the maximum, limit the speed of my CPU to reduce
      # heat and increase battery usage:
      CPU_MAX_PERF_ON_AC=95;
      CPU_MAX_PERF_ON_BAT=30;
    };
  };

    #environment = {
    #variables = {
    #http_proxy = "http://192.168.49.1:8000";
    #https_proxy = "http://192.168.49.1:8000";
    #ftp_proxy = "http://192.168.49.1:8000";
    #no_proxy = "localhost,127.0.0.1,::1";
    #};
    #};
    

  services.openssh.permitRootLogin = "yes";  # // or "no" if you want to disable root login
  services.openssh.passwordAuthentication = true; # /// or false to disable password authentication

  # Steam

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; 
 
  # Graphics
  hardware.opengl = {
    enable = true;
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

    xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
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

virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
programs.virt-manager.enable = true;

  
  nixpkgs.config.permittedInsecurePackages = [
 "electron-27.3.11"
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # this is a nixos experimental feature called flakes
  system.stateVersion = "24.05"; # Did you read the comment? tahdah
}

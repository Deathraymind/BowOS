# configuration.nix
{ config, pkgs, inputs, lib, ... }:

let
  username = builtins.getEnv "BOWOS_USER";
in


{
  imports =
    [ 
    ./stylix.nix
    /etc/nixos/hardware-configuration.nix 
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

    boot.loader.grub.configurationName = "BowOS";

    # this text is 3d-ASSCI
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
Welcome to BowOS \e[0m
\n \l
'';
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

  # Set you location
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
users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };



# ____            _    _              
#|  _ \  ___  ___| | _| |_ ___  _ __  
#| | | |/ _ \/ __| |/ / __/ _ \| '_ \ 
#| |_| |  __/\__ \   <| || (_) | |_) |
#|____/ \___||___/_|\_\\__\___/| .__/ 
#                              |_|      

  programs.hyprland = {
    enable = true;
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
    wl-color-picker
    neovim
    git
    kitty
    waybar
    rofi
    ethtool
    gnome.nautilus
    vlc
    wl-clipboard
    libva
    lazygit
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
    playerctl
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
    jq
    imagemagick
    ffmpegthumbs

    # theme stuff
    nwg-look
    hyprpaper
    fastfetch
    unstable.hyprlock 
    pavucontrol 
    pipewire
    xorg.xrandr
    home-manager
    htop
    playerctl
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
    v4l2-relayd
    v4l-utils
    android-tools
    cpufrequtils 
  ];




# ____                  _      _           
#/ ___|  ___ _ ____   _(_) ___(_) ___  ___ 
#\___ \ / _ \ '__\ \ / / |/ __| |/ _ \/ __|
# ___) |  __/ |   \ V /| | (__| |  __/\__ \
#|____/ \___|_|    \_/ |_|\___|_|\___||___/


  services.udisks2.enable = true; 
  security.polkit.enable = true;
  services.openssh.enable = true; 


# power saving
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_BOOST_ON_BAT=0;
      CPU_BOOST_ON_AC=1;
      CPU_MAX_PERF_ON_AC=95;
      CPU_MAX_PERF_ON_BAT=30;
    };
  };

  services.openssh.permitRootLogin = "yes"; 
  services.openssh.passwordAuthentication = true; 

 
  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;
  # Enable networking
  networking.networkmanager.enable = true; 

  # Bluetooth
  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true; 
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
    
    
  enable = true; 
  
  allowedTCPPorts = [ 9943 9944 51112 ]; 
  allowedUDPPorts = [ 9943 9944 51112 ]; 
  allowedTCPPortRanges = [  { from = 1714; to = 1764; }]; 
  allowedUDPPortRanges = [  { from = 1714; to = 1764; }]; 
 
};

# Virtual Machines
programs.virt-manager.enable = true;
virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };

  
nixpkgs.config.permittedInsecurePackages = [ "electron-27.3.11" ];
nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
system.stateVersion = "24.05"; 
}

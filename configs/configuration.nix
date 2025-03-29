# configuration.nix
{ config, pkgs, inputs, lib, ... }:

let
  username = builtins.getEnv "BOWOS_USER";
in
    # Use this command to rebuild the system :)
    # BOWOS_USER=bowyn sudo -E nixos-rebuild switch --impure --flake .#kvm
{
  imports =
    [
      ./stylix.nix
      /etc/nixos/hardware-configuration.nix 
      /etc/nixos/preferences/configuration-preferences.nix
      
    ];
  programs.zsh = {
    enable = true;
    loginShellInit = ''
      Hyprland & 
    '';
  };



  users.defaultUserShell = pkgs.zsh;
  system.activationScripts.update-grub-menu = {
    text = ''
      echo "Updating GRUB menu entry name..."

      GRUB_CFG="/boot/grub/grub.cfg"
      BACKUP_GRUB_CFG="/boot/grub/grub.cfg.bak"
      SEARCH_STR="\"NixOS"
      REPLACE_STR="\"BowOS"

      if [ -f "$GRUB_CFG" ]; then
          cp "$GRUB_CFG" "$BACKUP_GRUB_CFG"
          ${pkgs.gnused}/bin/sed -i "s/$SEARCH_STR/$REPLACE_STR/g" "$GRUB_CFG"
      else
          echo "Error: GRUB configuration file not found."
      fi
    '';
  };

  services.expressvpn.enable = true;

  boot.loader = {
    grub = {
      enable = true;
      # efiSupport = true;
      # devices = [ "nodev" ];
      configurationName = "BowOS";
      fontSize = 26;
      useOSProber = true;
    };
    efi = {
      # canTouchEfiVariables = true;
      # Optional: specify EFI mount point if non-standard
      # efiSysMountPoint = "/boot/efi";
    };
  };

  boot.loader.systemd-boot.enable = false;

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
  # Phone Camera
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" "acpi-cpufreq" ];
  boot.kernelPackages = pkgs.linuxPackages;


  qt.style = "adwaita-dark";
  qt.enable = true;

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };





  boot.extraModprobeConfig = ''
    options v4l2loopback video_nr=1 card_label="VirtualCam" exclusive_caps=1
  '';
  # Run this command to run the virtual camera
  # scrcpy --video-source=camera --camera-size=1920x1080 --v4l2-sink=/dev/video1 --no-video-playback --v4l2-buffer=50
  time.timeZone = lib.mkDefault "Asia/Tokyo";

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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "vboxusers" "disk" "kvm" "video" "render" "docker" ];
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
  #  obs-studio
  #  krita
  #  alvr
  #  expressvpn
  #  blender
  #  gcc
  #  libsForQt5.qtstyleplugin-kvantum
  #  libsForQt5.qt5ct
  #  libsForQt5.qtstyleplugins
  #  qt5.qtbase
  #  adwaita-qt
  #  wl-color-picker
  #  neovim
  #  git
  #  waybar
  #  rofi
  #  ethtool
  #  gnome.nautilus
  #  vlc
  #  wl-clipboard
  #  libva
  #  lazygit
  #  # Terminal
  #  zsh
  #  starship
  #  fzf
  #  kitty
  #  alacritty
  #  # audio
  #  pipewire
  #  pamixer
  #  # network
  #  networkmanager
  #  networkmanagerapplet
  #  # bluetooth
  #  bluez
  #  blueman
  #  brightnessctl
  #  playerctl
  #  swaynotificationcenter

  #  # screenshot
  #  grim
  #  slurp
  #  arduino-ide
  #  swappy
  #  cliphist
  #  hyprpicker

  #  ydotool

  #  # dependencies
  #  polkit-kde-agent
  #  xdg-desktop-portal-hyprland
  #  jq
  #  imagemagick
  #  ffmpegthumbs

  #  # theme stuff
  #  nwg-look
  #  hyprpaper
  #  fastfetch
  #  hyprlock
  #  pavucontrol
  #  pipewire
  #  xorg.xrandr
  #  home-manager
  #  htop
  #  playerctl
  #  dconf
  #  glib
  #  # Virtual Machine
  #  qemu
  #  gnome.gnome-disk-utility
  #  udisks2
  #  firefox
  #  polkit
  #  lxqt.lxqt-policykit
  #  ranger
  #  # Screen Sharing
  #  pipewire
  #  wireplumber
  #  # Phone Sync
  #  scrcpy
  #  v4l2-relayd
  #  v4l-utils
  #  android-tools
  #  cpufrequtils
  #  libsForQt5.qtstyleplugin-kvantum
  #  libsForQt5.qt5ct
  #  obsidian
  #  helvum
    # Rocm stuff 
  ];




  # ____                  _      _           
  #/ ___|  ___ _ ____   _(_) ___(_) ___  ___ 
  #\___ \ / _ \ '__\ \ / / |/ __| |/ _ \/ __|
  # ___) |  __/ |   \ V /| | (__| |  __/\__ \
  #|____/ \___|_|    \_/ |_|\___|_|\___||___/
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  virtualisation.docker.enable = true;
  services.udisks2.enable = true;
  security.polkit.enable = true;
  services.openssh.enable = true;
  programs.kdeconnect.enable = true;
  services.flatpak.enable = true;
  services.dbus.enable = true;

  programs.kdeconnect = {
    package = pkgs.gnomeExtensions.gsconnect;
  };


  # power saving
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

  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = true;


  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  home-manager.backupFileExtension = "backup";

  # File 
  services.gvfs.enable = true;

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
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];

  };

  # Virtual Machines
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "bowyn" ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-27.3.11" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";
}

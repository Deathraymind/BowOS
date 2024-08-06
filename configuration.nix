# configuration.nix
{ config, pkgs, inputs, lib, ... }:



{
  imports =
    [ 
      (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master") # this includes the nix os vs code server. 
      
      ./hardware-configuration.nix # Include the results of the hardware scan.
      
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

#,------.                ,--.     ,--.                 
#|  .-.  \  ,---.  ,---. |  |,-.,-'  '-. ,---.  ,---.  
#|  |  \  :| .-. :(  .-' |     /'-.  .-'| .-. || .-. | 
#|  '--'  /\   --..-'  `)|  \  \  |  |  ' '-' '| '-' ' 
#`-------'  `----'`----' `--'`--' `--'   `---' |  |-'  
#                                             `--'    

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  
#,------.               ,--.                                 
#|  .--. ' ,--,--. ,---.|  |,-. ,--,--. ,---.  ,---.  ,---.  
#|  '--' |' ,-.  || .--'|     /' ,-.  || .-. || .-. :(  .-'  
#|  | --' \ '-'  |\ `--.|  \  \\ '-'  |' '-' '\   --..-'  `) 
#`--'      `--`--' `---'`--'`--'`--`--'.`-  /  `----'`----'  
#                                     `---'          
  
  environment.systemPackages = with pkgs; [
    git
    kitty
    vscode
    waybar
    rofi
    nerdfonts

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
    
    hyprland 
    neofetch
    unstable.hyprlock # The unstable. is puleld from the unstable channle of nixos
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
    r2modman
    # Virtual Machine
    qemu
    discord
    r2mod_cli
    unstable.r2modman
    python3
    python311Packages.pip
    flatpak
    prismlauncher
    filezilla
    gnome.gnome-terminal
    gnome.gnome-disk-utility
    udisks2
    cava
    obsidian

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
    # rocmPackages.rocblas
    # rocmPackages.miopen
    # rocmPackages.hipfft
    # rocmPackages.hipcub

    # rocm-opencl-runtime
    chromium
    obs-studio
    arduino-ide
    radeontop

    ranger

  ];


  fonts.fonts = with pkgs; [
     nerdfonts # this pulls the nerdfonts from the nixos and makes it available. 
  ];

#,---.                          ,--.                     
#'   .-'  ,---. ,--.--.,--.  ,--.`--' ,---. ,---.  ,---.  
#`.  `-. | .-. :|  .--' \  `'  / ,--.| .--'| .-. :(  .-'  
#.-'    |\   --.|  |     \    /  |  |\ `--.\   --..-'  `) 
#`-----'  `----'`--'      `--'   `--' `---' `----'`----' 
  services.udisks2.enable = true; 

  security.polkit.enable = true;
  
  services.expressvpn.enable = true;
  
  services.flatpak.enable = true;

  

  services.openssh.enable = true; # enables the sshd server on the computer
  services.openssh.permitRootLogin = "yes";  # // or "no" if you want to disable root login
  services.openssh.passwordAuthentication = true; # // or false to disable password authentication
  
  services.vscode-server.enable = true; # this enables the vs code server. 
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # this is a nixos experimental feature called flakes

 networking.firewall = {
  enable = true; # Make sure the firewall is enabled
  allowedTCPPorts = [ 9943 9944 51112]; # List of TCP ports to open
  allowedUDPPorts = [ 9943 9944 51112]; # List of UDP ports to open, if needed
 
};


# Virtual Machines

virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;


  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  # If you want to use JACK applications, uncomment this
  # systemctl --user restart pipewire.service
  # systemctl --user restart pipewire-pulse.service
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; 
 
hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

services.xserver.videoDrivers = ["amdgpu"];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

  
  nixpkgs.config.permittedInsecurePackages = [
 "electron-25.9.0"
  ];



  # Enable networking
  networking.networkmanager.enable = true; # Enables dhcp and ethernet support IMPORTANT


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment? tahdah
}

# configuration.nix
{ config, pkgs, inputs, lib, ... }:

let
  username = builtins.getEnv "BOWOS_USER";
in
    # Use this command to rebuild the system :)
    # BOWOS_USER=bowyn sudo -E nixos-rebuild switch --impure --flake .#server
{
  imports =
    [
        ./stylix.nix
         /etc/nixos/hardware-configuration.nix 
      /etc/nixos/preferences/configuration-preferences.nix

    ];

  # What you want to start when user logins 
  programs.zsh = {
    enable = true;
    loginShellInit = ''
   
    '';
  };



  users.defaultUserShell = pkgs.zsh;
  system.activationScripts.update-grub-menu = {
    text = ''
      echo "Updating GRUB menu entry name..."

      GRUB_CFG="/boot/grub/grub.cfg"
      BACKUP_GRUB_CFG="/boot/grub/grub.cfg.bak"
      SEARCH_STR="\"NixOS"
      REPLACE_STR="\"BowOS-Server"

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
      enable = lib.mkForce true;
      # efiSupport = true;
      # devices = [ "nodev" ];
      configurationName = "BowOS-Server";
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
    Welcome to BowOS-Server \e[0m
    \n \l
  '';


  qt.style = "adwaita-dark";
  qt.enable = true;

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

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
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "disk" "docker" ];
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
  
  ];




  # ____                  _      _           
  #/ ___|  ___ _ ____   _(_) ___(_) ___  ___ 
  #\___ \ / _ \ '__\ \ / / |/ __| |/ _ \/ __|
  # ___) |  __/ |   \ V /| | (__| |  __/\__ \
  #|____/ \___|_|    \_/ |_|\___|_|\___||___/
    security.polkit.enable = true;
  

  ## Graphics
  ## _____ _                        _ _ 
  ##|  ___(_)_ __ _____      ____ _| | |
  ##| |_  | | '__/ _ \ \ /\ / / _` | | |
  ##|  _| | | | |  __/\ V  V / (_| | | |
  ##|_|   |_|_|  \___| \_/\_/ \__,_|_|_|

  networking.firewall = {


    enable = true;

    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];

  };

  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";
}

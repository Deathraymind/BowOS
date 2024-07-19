# home.nix
{ config, pkgs, lib, ... }:

{
   
   imports = [
    ./theme.nix # Calls the files theme.nix which contains the scripts and packages for theming.
  ];

  qt = {
  enable = true; # This enables qt themeing for KDE applications. 
  platformTheme = "qtct";

  
};

  home.file."/home/bowyn/.profile".source = ./home/.profile;  # Adjust the path to where you store .profile in your flake

  home.file."/home/bowyn/.config/" = { # this is where you want the file
    source = ./home/config; # this is where you are pulling the file from
    recursive = true; # recusris the e ntire directory
  };

  # TODO please change the username & home directory to your own
  home.username = "bowyn";
  home.homeDirectory = "/home/bowyn";
  
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # system tools
    kitty
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    hyprland
    rofi
    #Themeing
    gtk3
    dconf
    glib
    gsettings-desktop-schemas
    # Browser
    firefox
    dolphin
    gnome.nautilus
    hyprpaper
    
  ];



  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Deathraymind";
    userEmail = "deathraymind@gmail.com";
  };

  # Home manage version
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself2.
  programs.home-manager.enable = true;
  programs.starship.enable = false;

}
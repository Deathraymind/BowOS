# home.nix
{ config, pkgs, lib, ... }:

{
   
   imports = [
     #./theme.nix # Calls the files theme.nix which contains the scripts and packages for theming.
    ./theme.nix
  ];


  home.file."/home/bowyn/.profile".source = ./home/.profile;  # Adjust the path to where you store .profile in your flake
  home.file."/run/current-system/sw/etc/xdg/swaync/config.json".source = ./home/blueTheme/swaync/config.json;  # Adjust the path to where you store .profile in your flake
  home.file."/run/current-system/sw/etc/xdg/swaync/style.css".source = ./home/blueTheme/swaync/style.css;

  home.file = {
    "/home/bowyn/.config/swaync/adbconnect.sh" = {
      source = ./home/blueTheme/swaync/adbconnect.sh;
      target = "symlink"; # This is the default, creating a symlink
      mode = "0755";      # This ensures the file is executable
    };
    "/home/bowyn/.config/swaync/adbcamera.sh" = {
      source = ./home/blueTheme/swaync/adbcamera.sh;
      target = "symlink";
      mode = "0755";      # This ensures the file is executable
    };
    "/home/bowyn/.config/swaync/adbpair.sh" = {
      source = ./home/blueTheme/swaync/adbpair.sh;
      target = "symlink";
      mode = "0755";      # This ensures the file is executable
    };
  };




  home.file."/usr/share/rofi" = { # this is where you want the file
    source = ./home/blueTheme/rofi; # this is where you are pulling the file from
    recursive = true; # recusris the entire directory
  };

  home.file."/home/bowyn/.config/" = { # this is where you want the file
    source = ./home/blueTheme; # this is where you are pulling the file from
    recursive = true; # recusris the entire directory
  };

  # TODO please change the username & home directory to your own
  home.username = "bowyn";
  home.homeDirectory = "/home/bowyn";
  

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # system tools  
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
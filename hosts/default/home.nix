# home.nix
{ config, pkgs, lib, ... }:


{
   
   imports = [
     #./theme.nix # Calls the files theme.nix which contains the scripts and packages for theming.
        # ./theme.nix
    ./home/blueTheme/nvim/nvim.nix
    ./home/blueTheme/waybar/waybar.nix
        # ./homeStylix.nix
  ];

  home.file = { 
       "/home/bowyn/.profile".source = ./home/.profile; 
       "/run/current-system/sw/etc/xdg/swaync/config.json".source = ./home/blueTheme/swaync/config.json; 
       "/run/current-system/sw/etc/xdg/swaync/style.css".source = ./home/blueTheme/swaync/style.css;
  };

  home.file."/usr/share/rofi" = { # this is where you want the file
    source = ./home/blueTheme/rofi; # this is where you are pulling the file from
    recursive = true; # recusris the entire directory
  };

  home.file."/home/bowyn/.config/hypr/" = { 
    source = ./home/blueTheme/hypr; 
    recursive = true; 
  };

  home.file."/home/bowyn/.config/swaync/" = { 
    source = ./home/blueTheme/swaync; 
    recursive = true; 
  };


  home.file."/home/bowyn/.config/nvim/" = { 
    source = ./home/blueTheme/nvim; 
    recursive = true; 
  };

  home.username = "bowyn";
  home.homeDirectory = "/home/bowyn";
  

  home.packages = with pkgs; [
    nixd

  ];

 

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Deathraymind";
    userEmail = "deathraymind@gmail.com";
  };

  # Home manage version
  home.stateVersion = "24.05";

  programs.kitty.enable = true;
  programs.home-manager.enable = true;
  programs.starship.enable = false;


  # Let home Manager install and manage itself2.
}

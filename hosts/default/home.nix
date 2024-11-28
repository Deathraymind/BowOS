# home.nix
{ config, pkgs, lib, ... }: {
   
   imports = [
    ./home/blueTheme/nvim/nvim.nix
    ./home/blueTheme/waybar/waybar.nix
    ./homeStylix.nix
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
  

  # User Packages
  home.packages = with pkgs; [
    nixd
  ];

  programs = {
    kitty.enable = true;
    home-manager.enable = true;
    starship.enable = false;

    };
  
  # User Configuration
  programs.git = {
    enable = true;
    userName = "Deathraymind";
    userEmail = "deathraymind@gmail.com";
  };

  home.stateVersion = "24.05";
}

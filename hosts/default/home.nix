# home.nix
{ config, pkgs, lib, ... }: 

let
  username = builtins.getEnv "BOWOS_USER";
in

{

   
   imports = [
    ./home/blueTheme/nvim/nvim.nix
    ./home/blueTheme/waybar/waybar.nix
    ./homeStylix.nix
  ];

  home.file = { 
       "/home/${username}/.profile".source = ./home/.profile; 
       "/run/current-system/sw/etc/xdg/swaync/config.json".source = ./home/blueTheme/swaync/config.json; 
       "/run/current-system/sw/etc/xdg/swaync/style.css".source = ./home/blueTheme/swaync/style.css;
  };

  home.file."/usr/share/rofi" = { # this is where you want the file
    source = ./home/blueTheme/rofi; # this is where you are pulling the file from
    recursive = true; # recusris the entire directory
  };

  home.file."/home/${username}/.config/hypr/" = { 
    source = ./home/blueTheme/hypr; 
    recursive = true; 
  };

  home.file."/home/${username}/.config/swaync/" = { 
    source = ./home/blueTheme/swaync; 
    recursive = true; 
  };


  home.file."/home/${username}/.config/nvim/" = { 
    source = ./home/blueTheme/nvim; 
    recursive = true; 
  };

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  

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
    userName = "relaceme";
    userEmail = "bowos@example.com";
  };

  home.stateVersion = "24.05";
}

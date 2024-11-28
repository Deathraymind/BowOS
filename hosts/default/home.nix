# home.nix
{ config, pkgs, lib, ... }:


{
   
   imports = [
     #./theme.nix # Calls the files theme.nix which contains the scripts and packages for theming.
        # ./theme.nix
    ./home/blueTheme/nvim/nvim.nix
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

  home.file."/home/bowyn/.config/" = { # this is where you want the file
    source = ./home/blueTheme; # this is where you are pulling the file from
    recursive = true; # recusris the entire directory
  };

  home.username = "bowyn";
  home.homeDirectory = "/home/bowyn";
  

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    nixd

  ];

# home.nix
 
home.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
qt = {
    enable = true;
      style.package = pkgs.libsForQt5.breeze-qt5;
      style.name = "breeze-dark";
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Deathraymind";
    userEmail = "deathraymind@gmail.com";
  };

  # Home manage version
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself2.
  stylix.enable = true;
  programs.home-manager.enable = true;
  programs.starship.enable = false;
  stylix.targets.kitty.enable = true;
stylix.targets.kde.enable = true;
  stylix.polarity = "dark";
  stylix.image = /home/bowyn/bowos/wallpaper/wallpapers/wp.png;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.fonts = {
        monospace = {
            package = pkgs.google-fonts;  # Replace with the correct package for Roboto Mono
            name = "Roboto Mono";         # Specify the font name
        };
  };
}

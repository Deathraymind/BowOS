# home.nix
{  pkgs,   ... }: 

let
  username = builtins.getEnv "BOWOS_USER";
in 
{

  # Import additional configurations
  imports = [
    ./home/blueTheme/nvim/nvim.nix
    ./home/blueTheme/waybar/waybar.nix
    ./home/blueTheme/rofi/rofi.nix
    ./home/blueTheme/fastfetch/fastfetch.nix
    ./homeStylix.nix
  ];



  # File management
  home.file = {
    "/home/${username}/.profile".source = ./home/.profile;
    "/run/current-system/sw/etc/xdg/swaync/config.json".source = ./home/blueTheme/swaync/config.json;
    "/run/current-system/sw/etc/xdg/swaync/style.css".source = ./home/blueTheme/swaync/style.css;

    "/home/${username}/.config/hypr/" = { 
      source = ./home/blueTheme/hypr; 
      recursive = true; 
    };

    "/home/${username}/.config/swaync/" = { 
      source = ./home/blueTheme/swaync; 
      recursive = true; 
    };

    "/home/${username}/.config/nvim/" = { 
      source = ./home/blueTheme/nvim; 
      recursive = true; 
    };
  };

  # User details
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # User Packages
  home.packages = with pkgs; [
    nixd
  ];

  # Program configurations
  programs = {
    kitty.enable = true;
    home-manager.enable = true;
    starship.enable = false;
    git = {
      enable = true;
      userName = "Deathraymind";
      userEmail = "deathraymind@gmail.com";
    };
  };

  # State version
  home.stateVersion = "24.11";
}


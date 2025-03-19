# home.nix
{ pkgs, ... }:
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
    ./home/blueTheme/hypr/hyprland.nix
    ./homeStylix.nix
    ./home/blueTheme/swaync/swaync.nix
  ];
  # File management
  home.file = {
        # "/run/current-system/sw/etc/xdg/swaync/config.json".source = ./home/blueTheme/swaync/config.json;
        #"/run/current-system/sw/etc/xdg/swaync/style.css".source = ./home/blueTheme/swaync/style.css;
    #"/home/${username}/.config/hypr/" = { 
    #source = ./home/blueTheme/hypr; 
    #recursive = true; 
    #};
            # "/home/${username}/.config/swaync/" = {
            #source = ./home/blueTheme/swaync;
            #recursive = true;
        #};
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


  programs.starship = {
    enable = true;
    enableZshIntegration = true; # Enable for Bash (or enableZshIntegration for Zsh, etc.)
    settings = {
      format = ''
        [┌───────────────────>](bold green)
        [│](bold green)$directory$rust$package
        [└─>](bold green) '';

      # Wait 10 milliseconds for starship to check files under the current directory.
      scan_timeout = 10;

      # Disable the blank line at the start of the prompt
      add_newline = false;

      # Set 'foo' as custom color palette
      palette = "foo";

      # Define custom colors
      # Overwrite existing color
      blue = "21";
      # Define new color
      mustard = "#af8700";

    };
  };
  programs = {
    kitty.enable = true;
    alacritty.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Deathraymind";
      userEmail = "deathraymind@gmail.com";
    };
  };
  # State version
  home.stateVersion = "24.11";
}

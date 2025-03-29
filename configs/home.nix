# home.nix
{ pkgs, ... }:
let
  username = builtins.getEnv "BOWOS_USER";
in
{
  # Import additional configurations
  imports = [
    ./user/nvim/nvim.nix
    ./user/waybar/waybar.nix
    ./user/rofi/rofi.nix
    ./user/fastfetch/fastfetch.nix
    ./user/hypr/hyprland.nix
    ./user/swaync/swaync.nix
    ./homeStylix.nix
  ];
  # File management
  home.file = {
    "/home/${username}/.config/nvim/" = {
      source = ./user/nvim;
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

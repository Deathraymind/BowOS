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
    ./user/hypr/AxiomOS.nix
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
        format = "$directory$git_branch$git_status$character"; 
        character ={
            success_symbol = "[➜](bold green)";
            error_symbol = "[✗](bold red)";
        };
        directory = {
  truncation_length = 3;
  style = "blue";
};

git_branch = {
  symbol = "🌿 ";
  style = "green";
};
    };
  };
  programs = {
    zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true; 
        };
    kitty.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Deathraymind";
      userEmail = "deathraymind@gmail.com";
    };
  };
  # State version
  home.stateVersion = "25.05";
}

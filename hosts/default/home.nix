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
    alacritty.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Deathraymind";
      userEmail = "deathraymind@gmail.com";
    };
            # bash = {
            #enable = true;
            #enableCompletion = true;
            #profileExtra = ''
            #if [ "$(tty)" = "/dev/tty1" ]; then
            #exec Hyprland &> /dev/null
            #fi
            #'';
        #};
    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = true;
        
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
        };
        directory = {
          truncation_length = 3;
          truncate_to_repo = true;
          style = "bold cyan";
        };
        git_branch = {
          symbol = " ";
          style = "bold purple";
        };
        git_status = {
          style = "bold red";
          ahead = "⇡";
          behind = "⇣";
          diverged = "⇕";
          modified = "!";
        };
        cmd_duration = {
          min_time = 500;
          format = "took [$duration](bold yellow)";
        };
        nix_shell = {
          symbol = " ";
          format = "via [$symbol$state( \($name\))](bold blue) ";
        };
        battery = {
          full_symbol = " ";
          charging_symbol = " ";
          discharging_symbol = " ";
        };
        time = {
          disabled = false;
          format = "[$time]($style) ";
          style = "bold yellow";
        };
      };
    };
  };
  # State version
  home.stateVersion = "24.11";
}

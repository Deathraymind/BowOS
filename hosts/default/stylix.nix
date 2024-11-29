# stylix.nix
{ config, pkgs, inputs, lib, ... }: {

  stylix = {
    enable = true;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 32;
    };
    
    targets.console.enable = true;
    image = pkgs.fetchurl {
      url = "https://wallpapers-clan.com/wp-content/uploads/2024/02/jujutsu-kaisen-sukuna-anime-desktop-wallpaper-preview.jpg";
      sha256 = "sha256-bEBcdjXbUBZdbgxIz2pBzOi+wp47m/siB+1XI7hOUHY=";
    }; 

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      serif = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
    };
  };
}

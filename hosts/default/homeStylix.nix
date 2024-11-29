# homeStylix.nix
{ config, pkgs, lib, ... }: {

  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://wallpapers-clan.com/wp-content/uploads/2024/02/jujutsu-kaisen-sukuna-anime-desktop-wallpaper-preview.jpg";
      sha256 = "sha256-bEBcdjXbUBZdbgxIz2pBzOi+wp47m/siB+1XI7hOUHY=";
    }; 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    targets = {
      kitty.enable = true;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      # You can also set other font types if needed
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
 gtk = {
        enable = true;
        iconTheme = {
        name = "BeautyLine";
        package = pkgs.beauty-line-icon-theme;
      };
        };
}

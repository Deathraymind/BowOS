# homeStylix.nix
{ config, pkgs, lib, ... }: {

  stylix = {
    enable = true;
    image = /home/bowyn/bowos/wallpaper/wallpapers/wp.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    targets = {
      kitty.enable = true;
      kde.enable = true;
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

  icons = {
    package = pkgs.beauty-line-icon-theme;
    name = "BeautyLine";
  };
}

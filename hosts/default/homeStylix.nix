# homeStylix.nix
{ config, pkgs, lib, ... }: {

  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orxngc/walls-catppuccin-mocha/master/dominik-mayer-17.jpg";
      sha256 = "sha256-g/Bi1RfjMFxnFlu5ovok+vOkCCtZ8iC8Uf2fKabt9gA=";
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

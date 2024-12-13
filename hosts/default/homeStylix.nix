# homeStylix.nix
{ config, pkgs, lib, ... }: {

  stylix = {
    enable = true;
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orxngc/walls-catppuccin-mocha/master/dominik-mayer-17.jpg";
      sha256 = "sha256-g/Bi1RfjMFxnFlu5ovok+vOkCCtZ8iC8Uf2fKabt9gA=";
    }; 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    targets = {
      kitty.enable = true;
    };

          # You can also set other font types if needed
           };
 gtk = {
        enable = true;
        iconTheme = {
        name = "WhiteSur";
        package = pkgs.whitesur-icon-theme;
      };
        };

      
}


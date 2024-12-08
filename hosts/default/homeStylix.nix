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
        name = "BeautyLine";
        package = pkgs.beauty-line-icon-theme;
      };
        };

      
    home.packages = with pkgs; [pkgs.utterly-nord-plasma];
    xdg.configFile = {
      "Kvantum/Utterly-Nord-Solid-Plasma/Utterly-Nord-Solid/Utterly-Nord-Solid.kvconfig".source = "${pkgs.utterly-nord-plasma}/share/Kvantum/Utterly-Nord-Solid/Utterly-Nord-Solid.kvconfig";
      "Kvantum/Utterly-Nord-Solid-Plasma/Utterly-Nord-Solid/Utterly-Nord-Solid.svg".source = "${pkgs.utterly-nord-plasma}/share/Kvantum/Utterly-Nord-Solid/Utterly-Nord-Solid.svg";
      "Kvantum/Utterly-Nord-Solid-Plasma/Utterly-Nord-Solid/Nord.patchconfig".source = "${pkgs.utterly-nord-plasma}/share/Kvantum/Utterly-Nord-Solid/Nord.patchconfig";
      "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=Utterly-Nord-Solid";
    };
}


{ config, pkgs, inputs, lib, ... }: 

{


stylix.enable=true;
stylix.cursor.package = pkgs.bibata-cursors;
stylix.image = /home/bowyn/bowos/wallpaper/wallpapers/wp.png;
stylix.cursor.name = "Bibata-Modern-Ice";
stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
stylix.cursor.size = 32;
stylix.polarity = "dark";
stylix.autoEnable = true;
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  stylix.fonts = {
        monospace = {
            package = pkgs.google-fonts;  # Replace with the correct package for Roboto Mono
            name = "Roboto Mono";         # Specify the font name
        };
  };

}

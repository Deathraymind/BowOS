# template-theme.nix

{ config, pkgs, lib, ... }: 
{

gtk = {
    enable = true;
    # theme
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        variant = "mocha";
        size = "compact";
      };
    };
    # cursor Theme
    cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
    # Icon Pack
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
};
}
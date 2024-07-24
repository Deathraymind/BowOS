{ config, pkgs, lib, ...}:

{
# Cursor Theme
gtk.enable = true;
gtk.cursorTheme.package = pkgs.bibata-cursors;
gtk.cursorTheme.name = "Bibata-Modern-Ice";
}
{ config, pkgs, lib, ... }: 
{
  gtk = {
    enable = true;
    
    # GTK Theme
    theme = {
      name = "Colloid-Dark";  # Update the theme name
      package = pkgs.colloid-gtk-theme;  # Ensure this package is available
    };
  
    # Cursor Theme
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    
    # Icon Theme
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
  };
}
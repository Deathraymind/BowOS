{ config, pkgs, inputs, lib, ... }: 

{

stylix.cursor.package = pkgs.bibata-cursors;
stylix.cursor.name = "Bibata-Modern-Ice";
stylix.cursor.size = 32;
targets.kitty.enable = true;

}

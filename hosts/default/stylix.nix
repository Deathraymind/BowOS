# stylix.nix
{ config, pkgs, inputs, lib, ... }: {

  stylix = {
    enable = true;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 32;
    };

    targets.console.enable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orxngc/walls-catppuccin-mocha/master/dominik-mayer-17.jpg";
      sha256 = "sha256-g/Bi1RfjMFxnFlu5ovok+vOkCCtZ8iC8Uf2fKabt9gA=";
    };

    polarity = "dark";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";




    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
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

    # https://github.com/tinted-theming/base16-schemes GO HERE FOR THEMES
  stylix.base16Scheme.base00 = "1e1e2e"; # base
  stylix.base16Scheme.base01 = "181825"; # mantle
  stylix.base16Scheme.base02 = "313244"; # surface0
  stylix.base16Scheme.base03 = "45475a"; # surface1
  stylix.base16Scheme.base04 = "585b70"; # surface2
  stylix.base16Scheme.base05 = "cdd6f4"; # text
  stylix.base16Scheme.base06 = "f5e0dc"; # rosewater
  stylix.base16Scheme.base07 = "b4befe"; # lavender
  stylix.base16Scheme.base08 = "f38ba8"; # red
  stylix.base16Scheme.base09 = "fab387"; # peach
  stylix.base16Scheme.base0A = "f9e2af"; # yellow
  stylix.base16Scheme.base0B = "a6e3a1"; # green
  stylix.base16Scheme.base0C = "94e2d5"; # teal
  stylix.base16Scheme.base0D = "89b4fa"; # blue
  stylix.base16Scheme.base0E = "cba6f7"; # mauve
  stylix.base16Scheme.base0F = "f2cdcd"; # flamingo
}

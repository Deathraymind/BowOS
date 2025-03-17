# homeStylix.nix
{ config, pkgs, lib, ... }: {

  stylix = {
    enable = true;
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orxngc/walls-catppuccin-mocha/master/dominik-mayer-17.jpg";
      sha256 = "sha256-g/Bi1RfjMFxnFlu5ovok+vOkCCtZ8iC8Uf2fKabt9gA=";
    };
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    targets = {
      kitty.enable = true;
      alacritty.enable = true;
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


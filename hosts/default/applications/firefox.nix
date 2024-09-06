#firefox.nix

{ config, pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {




      extensions = [

      ];

    };
  };
}

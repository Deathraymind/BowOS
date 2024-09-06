#firefox.nix

{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
  };
}

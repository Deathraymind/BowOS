# applications.nix 
# A configuration file for apps
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sshd 
  ];

  }


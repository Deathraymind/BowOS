{ config, lib, pkgs, ...}:

{

    imports = [
        ./hardware-configuration.nix
    ];
boot.loader.grub.device = "nodev";
boot.loader.grub.enable = true;
syste.stateVersion = "24.05";

}

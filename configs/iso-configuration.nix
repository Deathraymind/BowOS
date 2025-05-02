{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    # to build the os run
    # sudo dd bs=4M if=result/iso/nixos-25.05.19700101.dirty-x86_64-linux.iso of=/dev/sdX status=progress oflag=sync
    #  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=./iso.nix
    # nix build .#nixosConfigurations.bowos.config.system.build.isoImage --impure
    # to creat a .nar file with all the goofy files use this 
    # nix-store -qR /run/current-system > installed-packages.txt
    # sed -i '/dbus/d' installed-packages.txt 
    # nix-store --export $(cat installed-packages.txt) > bowos-packages.nar
    # scp root@192.168.122.53:/mnt/all-installed-packages.nar /home/bowyn/BowOSv0.01/iso
    # Provide an initial copy of the NixOS channel so that the user
    # nix-store --import < /path/to/your.nar --store /mnt/nix/store

    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    <nixpkgs/nixos/modules/system/etc/etc.nix>
  ];


  environment.systemPackages = with pkgs; [
    # Include all your packages here
    openssh 
    neovim
    git 
  ];

  environment.etc."issue".text = ''
    \e[34m
    .--------------------------------------------.
    |██████╗  ██████╗ ██╗    ██╗ ██████╗ ███████╗|
    |██╔══██╗██╔═══██╗██║    ██║██╔═══██╗██╔════╝|
    |██████╔╝██║   ██║██║ █╗ ██║██║   ██║███████╗|
    |██╔══██╗██║   ██║██║███╗██║██║   ██║╚════██║|
    |██████╔╝╚██████╔╝╚███╔███╔╝╚██████╔╝███████║|
    |╚═════╝  ╚═════╝  ╚══╝╚══╝  ╚═════╝ ╚══════╝|
    '--------------------------------------------'
    Welcome to BowOS-Server
    \e[0m

    \e[34mSteps to install:\e[0m
    \e[34m1. Set a root password:\e[0m
       \e[34msudo passwd root\e[0m
    \e[34m2. switch to root:\e[0m
       \e[34msu root\e[0m
    \e[34m3. Navigate to the /etc directory:\e[0m
       \e[34mcd /etc\e[0m
    \e[34m4. Run the installation script:\e[0m
       \e[34mbash install-bowos.sh\e[0m
  '';











  # isoImage.squashfsCompression = "gzip -Xcompression-level 1";
  isoImage.squashfsCompression = "gzip -Xcompression-level 4";
  isoImage.isoName = lib.mkForce "bowos-${config.system.nixos.version}.iso";

  environment.shellInit = ''
    echo "Installer Countdown ctrl-c to escape to shell"
    sleep 1
    echo "4"

    sleep 1
    echo "3"

    sleep 1
    echo "2"

    sleep 1
    echo "1"

    git clone --branch bowos-server https://github.com/deathraymind/bowos
    sudo mount -o remount,size=10G,noatime /nix/.rw-store
    cd bowos/installer 
    bash install.sh

    '';

services.xserver.displayManager.autoLogin = lib.mkForce {
    enable = true;
    user = "root";
  };
  services.getty.autologinUser = lib.mkForce "root";
  users.users.root.initialPassword = "";
  


  services.openssh.enable = true; # enables the sshd server on the computer 
  services.openssh.permitRootLogin = "yes"; # // or "no" if you want to disable root login
  services.openssh.passwordAuthentication = true; # // or false to disable password authentication


  services.udisks2.enable = true;
  security.polkit.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };



  # Graphics




  stylix = {
    enable = true;

    targets.console.enable = true;
    image = pkgs.fetchurl {
      url = "https://wallpapers-clan.com/wp-content/uploads/2024/02/jujutsu-kaisen-sukuna-anime-desktop-wallpaper-preview.jpg";
      sha256 = "sha256-bEBcdjXbUBZdbgxIz2pBzOi+wp47m/siB+1XI7hOUHY=";
    };

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05";
}

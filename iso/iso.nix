{ config, pkgs, lib, ... }:

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
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      python3
      rsync
      python3Packages.textual
      wl-color-picker
        neovim
        git
        kitty
        waybar
        rofi
        ethtool
        gnome.nautilus
        vlc
        wl-clipboard
        libva
        lazygit
        # audio
        pipewire
        pamixer
        # network
        networkmanager
        networkmanagerapplet
        # bluetooth
        bluez
        blueman
        brightnessctl
        playerctl
        swaynotificationcenter

        # screenshot
        grim
        slurp
        swappy
        cliphist
        hyprpicker

        # dependencies
        polkit-kde-agent
        xdg-desktop-portal-hyprland
        jq
        imagemagick
        ffmpegthumbs

        # theme stuff
        nwg-look
        hyprpaper
        fastfetch
        hyprlock 
        pavucontrol 
        pipewire
        xorg.xrandr
        home-manager
        htop
        playerctl
        dconf
        glib
        # Virtual Machine
        qemu
        gnome.gnome-disk-utility
        udisks2
        firefox
        polkit
        lxqt.lxqt-policykit
        ranger
        # Screen Sharing
        pipewire
        wireplumber
        # Phone Sync
        scrcpy
        v4l2-relayd
        v4l-utils
        android-tools
        cpufrequtils
        hyprland


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
Welcome to BowOS
\e[0m

\e[34mSteps to install:\e[0m
\e[34m1. Set a root password:\e[0m
   \e[34msudo passwd root\e[0m
\e[34m2. Navigate to the /etc directory:\e[0m
   \e[34mcd /etc\e[0m
\e[34m3. Run the installation script:\e[0m
   \e[34mbash install-bowos.sh\e[0m
'';


  boot.loader.grub = lib.mkForce {
    enable = true;
    device = "nodev"; # Required for ISO image builds
    extraConfig = ''
      set menu_color_normal=white/black
      set menu_color_highlight=black/white
      echo "Custom Banner: Welcome to the BowOS Installer"
    '';
  };


    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix for the types of fonts
    isoImage.squashfsCompression = "gzip -Xcompression-level 1";
    environment.etc."install_bowos.sh".source = ./install_bowos.sh;
    # environment.etc."bowos-packages.nar".source = ./bowos-packages.nar;
    # system.build.isoImage.isoName = lib.mkForce "bowos-x86-v1.0.1"; 


    services.openssh.enable = true; # enables the sshd server on the computer 
    services.openssh.permitRootLogin = "yes";  # // or "no" if you want to disable root login
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

# power saving
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_BOOST_ON_BAT=0;
      CPU_BOOST_ON_AC=1;
      CPU_MAX_PERF_ON_AC=95;
      CPU_MAX_PERF_ON_BAT=30;
    };
  };


 
  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;

  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true; 
  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

    xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  };



programs.virt-manager.enable = true;
virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };




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
}

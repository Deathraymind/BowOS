{ pkgs, lib, ...}:
{

hardware.opentabletdriver.enable = true; # OTD supports Wayland
services = {
udisks2.enable = true;
dbus.enable = true;
flatpak.enable = true;
expressvpn.enable=true;
xserver.wacom.enable = true;
# SSH
openssh.enable = true;
openssh.settings.PasswordAuthentication = true;
openssh.settings.PermitRootLogin = lib.mkForce "no";

gvfs.enable = true;
blueman.enable = true;
};

services.syncthing = {
    enable = false;
    openDefaultPorts = true; 
    settings.gui = {
        user = "bowyn";
        password = "6255";
    };

};

networking.networkmanager.enable = true;
programs.adb.enable = true;
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

programs.steam = {
enable = true;
remotePlay.openFirewall = true;
dedicatedServer.openFirewall = true;
localNetworkGameTransfers.openFirewall = true;
  
};

programs.virt-manager.enable = true;
virtualisation.libvirtd = {
enable = true;
qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
};

hardware.bluetooth = {
enable = true;
powerOnBoot = true;
};

services.tlp = {
enable = true;
settings = {
  CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  CPU_BOOST_ON_BAT = 0;
  CPU_BOOST_ON_AC = 1;
  CPU_MAX_PERF_ON_AC = 95;
  CPU_MAX_PERF_ON_BAT = 30;
};
};
}

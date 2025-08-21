{ config, pkgs, ... }:

{
  # Modern graphics stack (NixOS 24.05+)
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;  # optional

  services.sunshine = {
    enable = true;
    openFirewall = true;  # opens 47984-47990/udp + 47990/tcp by default
    settings = {
      # optional niceties
      # web UI at https://your.server.ip:47990
      min_log_level = "info";
    };
  };
}


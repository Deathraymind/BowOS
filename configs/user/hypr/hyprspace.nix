{ lib, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
        pkgs.hyprlandPlugins.hyprspace
    ];
    settings = {


      bind = [
        "bind = SUPER, Tab, overview:toggle,"
    ];
    };
};
}


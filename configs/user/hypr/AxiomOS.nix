{lib, ...}: {
    wayland.windowManager.hyprland = {
        enable=true;
        settings = {
            exec-once = [];

      };
          bind = [
            "SUPER, Q, killactive,"
            "SUPER, W, togglefloating,"
            "SUPER, A, exec, rofi -show drun"
            "ALT, return, fullscreen,"
            "SUPER, T, exec, kitty"
            "SUPER, I, exec, wl-color-picker"

            # Switch workspaces relative
            "SUPER CTRL, right, workspace, r+1"
            "SUPER CTRL, left, workspace, r-1"
            "SUPER CTRL, L, workspace, r+1"
            "SUPER CTRL, H, workspace, r-1"

            # Move window to relative workspace
            "SUPER CTRL ALT, right, movetoworkspace, r+1"
            "SUPER CTRL ALT, left, movetoworkspace, r-1"
            "SUPER CTRL ALT, L, movetoworkspace, r+1"
            "SUPER CTRL ALT, H, movetoworkspace, r-1"

            # Move window in workspace
            "SUPER SHIFT CONTROL, left, movewindow, l"
            "SUPER SHIFT CONTROL, right, movewindow, r"
            "SUPER SHIFT CONTROL, up, movewindow, u"
            "SUPER SHIFT CONTROL, down, movewindow, d"
            "SUPER SHIFT CONTROL, H, movewindow, l"
            "SUPER SHIFT CONTROL, L, movewindow, r"
            "SUPER SHIFT CONTROL, K, movewindow, u"
            "SUPER SHIFT CONTROL, J, movewindow, d"
        ];
        bindm=[
        "SUPER, Z, movewindow"
        "SUPER, X, resizewindow"
        ];
        bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", xf86monbrightnessup, exec, brightnessctl set 5%+"
        ", xf86monbrightnessdown, exec, brightnessctl set 5%-"
        ", xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ", xf86audiolowervolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
        ", xf86audiomute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
      ];
     general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 1;
        layout = "dwindle";
      };
      master = {
        inherit_fullscreen = true; # Master
        drop_at_cursor = true;
      };
        #decoration = {
        #active_opacity = 0.99;
        #inactive_opacity = 0.98;
        #shadow = {
        #enabled = true;
        #   range = 10;
        #};
        #rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 4;
          new_optimizations = true;
        };
         services.hyprpaper = {
        enable = true;
        settings = {
            preload = [
                "wallpaper.png"
            ];
            wallpaper = [ 
                ",wallpaper.png"
            ];
            splash = false;
        };
    };



    
    };





}

{ lib, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "hyprlock -c ~/BowOS/configs/user/hypr/hyprlock.conf"
        "hyprpaper"
        "mkdir -p ~/Pictures/screenshots"
        "waybar"
        "blueman-applet"
        "nm-applet"
        "lxqt-policykit-agent"
        "swaync"
      ];

     input = {
        # Disable mouse acceleration for consistent ydotool coordinates
        force_no_accel = true;
        accel_profile = "flat";
        sensitivity = 0.0;
        
        # Optional: if you have specific mouse devices causing issues
        # You can add per-device settings here
      };
      # Basic window manipulation
      bind = [
        "SUPER, Q, killactive,"
        "SUPER, DELETE, exit,"
        "SUPER, W, togglefloating,"
        "SUPER, A, exec, rofi -show drun"
        "SUPER, TAB, exec, rofi -show window -theme-str 'window { width: 1500; height: 500; } listview { lines: 15; }'"
        "SUPER, G, togglegroup," # dwindle
        "ALT, return, fullscreen,"
        "SUPER, I, togglesplit," # dwindle

        # Screenshots
        "SUPER, P, exec, grim -g \"$(slurp)\" ~/Pictures/screenshots/temp_screenshot.png && swappy -f ~/Pictures/screenshots/temp_screenshot.png --output-file ~/Pictures/screenshots/screenshot_$(date +\"%Y%m%d_%H%M%S\").png"
        # AI answers 
        "SUPER, V, exec, kitty --title 'ai-response' -e bash -c '~/Documents/BowOSAi/target/debug/BowosAI -p; echo -e \"\\n\\nPress any key to close\"; read -n 1; pkill swappy'"
        "SUPER, B, exec, kitty --title 'ai-response' -e bash -c '~/Documents/BowOSAi/target/debug/BowosAI -c; echo -e \"\\n\\nPress any key to close\"; read -n 1'"

        # Toggle Waybar
        "SUPER, R, exec, pgrep waybar && pkill waybar || waybar &"

        # Update 
        "Super, O, exec, kitty --title 'update' -e bash -c 'BOWOS_USER=bowyn sudo -E nixos-rebuild switch --impure --flake BowOS/.#kvm; echo -e \"\\n\\nPress any key to close\"; read -n 1' "

        # Application shortcuts
        "SUPER, T, exec, kitty"
        "SUPER, E, exec, nautilus"
        "SUPER, C, exec, code"
        "SUPER, F, exec, flatpak run io.github.zen_browser.zen"
        "SUPER, C, exec, wl-color-picker"

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

        # Workspace scroll
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        # Special workspace (scratchpad)
        "SUPER ALT, S, movetoworkspacesilent, special"
        "SUPER, S, togglespecialworkspace,"

        # Move focus
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, J, movefocus, u"
        "SUPER, K, movefocus, d"
        # Move focus Master 
        "SUPER ALT, left, layoutmsg, cycleprev loop"
        "SUPER ALT, left, layoutmsg, swapwithmaster"
        "SUPER ALT, right, layoutmsg, cyclenext loop"
        "SUPER ALT, right, layoutmsg, swapwithmaster"

        # Switch workspaces directly
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        # Move window to workspace
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
      ];

      # Move/resize with mouse
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER, Z, movewindow"
        "SUPER, X, resizewindow"
        ", longpress:2, movewindow"
        ", longpress:3, resizewindow"
      ];

      # Media/function keys
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
      gestures = {
        workspace_swipe = true; 
      };
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
      };
      master = {
        inherit_fullscreen = true; # Master
        drop_at_cursor = true;
      };
      decoration = {
        active_opacity = 0.99;
        inactive_opacity = 0.98;
        shadow = {
            enabled = true;
            range = 10;
        };
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 4;
          new_optimizations = true;
        };
        animations = {

          bezier = [
            "wind, 0.05, 0.9, 0.1, 1.05"
            "winIn, 0.1, 1.1, 0.1, 1.1"
            "winOut, 0.3, -0.3, 0, 1"
            "liner, 1, 1, 1, 1"
          ];

          animation = [
            "windows, 1, 6, wind, popin"
            "windowsIn, 1, 6, winIn, popin"
            "windowsOut, 1, 5, winOut, popin"
            "windowsMove, 1, 5, wind, popin"
            "border, 1, 1, liner"
            "borderangle, 1, 30, liner, loop"
            "fade, 0" # the fade animation disabled opactiy change in transisiotion
            "workspaces, 1, 5, wind"
          ];
        };
       windowrulev2 = lib.mkForce [
    #------for update window------#
    "float, class:^(kitty)$, title:^(update)$"
    "float, class:^(kitty)$, initialTitle:^(update)$" # kitty --title "update"
    "size 50% 10%, class:^(kitty)$, title:^(update)$" # Optional: set size to 80% width, 50% height
    "move 25% 5%, class:^(kitty)$, title:^(update)$" # moves it down from the top h/w
    "opacity .70 .70, title:^(update)$"

    #------for ai-response window------#
    "float, class:^(kitty)$, title:^(ai-responose)$"
    "float, class:^(kitty)$, initialTitle:^(ai-response)$" 
    "size 50% 30%, class:^(kitty)$, title:^(ai-response)$" 
    "move 25% 5%, class:^(kitty)$, title:^(ai-response)$" 
    "opacity .70 .70, title:^(ai-response)$"


    #------for ai-response window------#
    "unset, class:^(firefox)$"
    "opacity 1 1,class:^(firefox)$"
];        monitor = [
                     "DP-1, 2560x1440@165, 0x0, 1"
                    # "HDMI-A-1,3840x2160@60,0x0, 2"
                     "HDMI-A-1,1920x1080@75,-1920x0,1"
                     "DP-2,1920x1080@60,-1920x0,1"
                     "DP-3,1920x1080@60,+1920x0,1"
                    "Virtual-1, 1920x1080@60, 0x0, 1"
                     "eDP-1, 1920x1080@60, 0x0 ,1"
        ];
      };
    };
  };
    services.hyprpaper = {
        enable = true;
        settings = {
            preload = [
                "/home/bowyn/BowOS/wallpaper/darknet.png"
            ];
            wallpaper = [ 
                ",/home/bowyn/BowOS/wallpaper/darknet.png"
            ];
            splash = false;
        };
    };
    programs.hyprlock.enable = true;

     services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock >/dev/null || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock -c ~/BowOS/configs/user/hypr/hyprlock.conf";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume  = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}

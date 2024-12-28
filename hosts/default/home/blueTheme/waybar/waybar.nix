{
  pkgs,
  lib,
  host,
  config,
  ...
}:


{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        exclusive = true;
        position = "top";
        passthrough = false;
        height = 20;
        gtk-layer-shell = true;
        modules-left = [
          "cpu"
          "battery"
          "memory"
        ];
        modules-center = [
          "hyprland/workspaces"
          "clock"
          "custom/launcher"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "tray"
          "custom/notifications"
        ];
        
        "hyprland/workspaces" = {
          format = "{icon} {windows}";
          format-window-seperator = " ";
          window-rewrite-default = "";
          window-rewrite = {
            kitty = "";
            code = "󰨞";
          };
        };
        
        clock = { 
          format = "{:%a, %e %b, %I:%M %p}";
          on-click = "firefox https://calendar.google.com";
        };
        
        cpu = {
          interval = 10;
          format = "  {usage}%";
          max-length = 10;
        };
        
        memory = {
          interval = 1;
          format = "  {used:.01f}G/{total:0.1f}G";
        };
        
        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃠"];
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
          min-length = 6;
        };
        
        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = " Muted";
          on-click = "pavucontrol -t 3";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
        };
        
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon}  {capacity}% ";
          format-charging = " {capacity}% ";
          format-plugged = " {capacity}% ";
          format-alt = "{time} {icon} ";
          format-icons = ["" "" "" "" ""];
        };
        
        tray = {
          icon-size = 24;
          spacing = 10;
        };
        
        "custom/notifications" = {
          format = "";
          on-click = "swaync-client -t";
        };
        
        "custom/launcher" = {
          format = "";
          on-click = "rofi -show run";
        };
      }
    ];

    # Theme Waybar

  style = lib.concatStrings [
''

* {
    border: none;
    border-radius: 0;
    font-family: "JetBrainsMono Nerd Font";
    font-weight: bold;
    font-size: 14px;
    min-height: 20px;
}

window#waybar {
    background: transparent; /* if this is going to work make sure to have blur off in hyprland */
    color: #cad3f5;
}

#tooltip {
    opacity: 0.9;
    background: #${config.stylix.base16Scheme.base00};
    border-radius: 10px;
    border-width: 2px;
    border-style: solid;
}

#tray {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
}

#tray:hover {
    background-color: #89B4FB;
}

#custom-gpu-usage {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 10px 10px 0px;
}



#bluetooth:hover {
    background-color: #89B4FB;
}

#battery {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
}

#pulseaudio {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 10px 0px 0px 10px;
    transition: background-color 0.3s ease;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
    border-left: 2px solid #${config.stylix.base16Scheme.base0D};
}

#pulseaudio:hover {
    background-color: #89B4FB;
    
}

#backlight {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    transition: background-color 0.3s ease;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
}

#backlight:hover {
    background-color: #89B4FB;
}



#memory {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 10px 10px 0px;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
    border-right: 2px solid #${config.stylix.base16Scheme.base0D};
}

#cpu {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 8px;
    margin-right: 0px;
    border-radius: 10px 0px 0px 10px;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
    border-left: 2px solid #${config.stylix.base16Scheme.base0D}; 
}

#clock {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
    
}

#custom-divider {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
}

#custom-notifications {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 8px;
    border-radius: 0px 10px 10px 0px;
    transition: background-color 0.3s ease;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
    border-right: 2px solid #${config.stylix.base16Scheme.base0D}; 
}

#custom-notifications:hover {
    background-color: #89B4FB;
}

#custom-launcher {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 10px 10px 0px;
    border: solid #${config.stylix.base16Scheme.base0D};
    border-right: 2px solid #${config.stylix.base16Scheme.base0D}; /* Explicitly set the right border */
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
    transition: background-color 0.3s ease;
}

#custom-launcher:hover {
    background-color: #89B4FB;
}

#workspaces {
    background: #${config.stylix.base16Scheme.base00};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 10px 0px 0px 10px;
    color: #B8C0E2;
    border-top: 2px solid #${config.stylix.base16Scheme.base0D};
    border-bottom: 2px solid #${config.stylix.base16Scheme.base0D};
    border-left: 2px solid #${config.stylix.base16Scheme.base0D}; 
}

#workspaces button label {
    color: #B8C0E2;
    font-size: 14px;
    padding: 0; /* Removes padding */
    margin: 0; /* Removes margin */
}

#workspaces button:hover {
    background-color: #89B4FB;
}



''
  ]; 
  }; 
}

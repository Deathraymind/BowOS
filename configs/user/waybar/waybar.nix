{ pkgs
, lib
, host
, config
, ...
}:

let 
    colors={
        background = config.stylix.base16Scheme.base00;

        border = "2px solid #${config.stylix.base16Scheme.base0D}";
    };
in
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
          "custom/configure"
          "custom/update"
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
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
          min-length = 6;
        };
        "custom/update" = {
            format = "󰚰";
            on-click = "kitty --title 'update' -e bash -c 'BOWOS_USER=bowyn sudo -E nixos-rebuild switch --impure --flake BowOS/.#kvm; echo -e \"\\n\\nPress any key to close\"; read -n 1'";
        };
        "custom/configure" = {
            format = "";
            on-click = "kitty -e bash -c 'cd BowOS && nvim configs/configuration.nix'";
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
            default = [ "" "" "" ];
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
          format-icons = [ "" "" "" "" "" ];
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
    background: #${colors.background};
    border-radius: 10px;
    border-width: 2px;
    border-style: solid;
}

#tray {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    border-top: ${colors.border};
    border-bottom: ${colors.border}; 
}

#tray:hover {
    background-color: #89B4FB;
}

#custom-gpu-usage {
    background: #${colors.background};
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
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    border-top: ${colors.border}; 
    border-bottom: ${colors.border};
}
#memory {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    border-top: ${colors.border};
    border-bottom: ${colors.border};
}


#pulseaudio {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 10px 0px 0px 10px;
    transition: background-color 0.3s ease;
    border-top: ${colors.border};
    border-bottom: ${colors.border};
    border-left: ${colors.border}; 
}

#pulseaudio:hover {
    background-color: #89B4FB;
    
}

#backlight {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    transition: background-color 0.3s ease;
    border-top: ${colors.border};
    border-bottom: ${colors.border}; 
}
#backlight:hover {
    background-color: #89B4FB;
}



#custom-update {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 10px 10px 0px;
    border-top: ${colors.border};
    border-bottom: ${colors.border};
    border-right: ${colors.border}; 
}
#custom-update:hover {
    background-color: #89B4FB;
}


#custom-configure {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    border-top: ${colors.border};
    border-bottom: ${colors.border};
    }
#custom-configure:hover {
    background-color: #89B4FB;
}


#cpu {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 8px;
    margin-right: 0px;
    border-radius: 10px 0px 0px 10px;
    border-top: ${colors.border}; 
    border-bottom: ${colors.border};
    border-left: ${colors.border};
    }

#clock {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
    border-top: ${colors.border};
    border-bottom: ${colors.border};    
}

#custom-divider {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 0px 0px 0px;
}

#custom-notifications {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 8px;
    border-radius: 0px 10px 10px 0px;
    transition: background-color 0.3s ease;
    border-top: ${colors.border}; 
    border-bottom: ${colors.border};
    border-right: ${colors.border};
    }

#custom-notifications:hover {
    background-color: #89B4FB;
}

#custom-launcher {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 0px 10px 10px 0px;
    border: solid #${config.stylix.base16Scheme.base0D};
    border-right: ${colors.border};  /* Explicitly set the right border */
    border-top: ${colors.border};
    border-bottom: ${colors.border};
    transition: background-color 0.3s ease;
}

#custom-launcher:hover {
    background-color: #89B4FB;
}

#workspaces {
    background: #${colors.background};
    opacity: 0.9;
    padding: 0px 10px;
    margin-top: 4px;
    margin-bottom: 1px;
    margin-left: 0px;
    margin-right: 0px;
    border-radius: 10px 0px 0px 10px;
    color: #B8C0E2;
    border-top: ${colors.border};
    border-bottom: ${colors.border};
    border-left: ${colors.border};
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


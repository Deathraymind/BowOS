{lib, pkgs, ...}: {
    wayland.windowManager.hyprland = {
        plugins = [
pkgs.hyprlandPlugins.hyprbars
        ];

settings = {
"plugin:hyprbars" = {
  bar_height = 25;
  bar_color = "0xee1e1e2e";     # Dark background (Alpha: ee, Color: 1e1e2e)
  "col.text" = "0xffcdd6f4";    # Light text (Alpha: ff, Color: cdd6f4)
  bar_text_font = "Sans";       # Manually set your font name here
  bar_text_size = 12;
  bar_part_of_window = true;

  hyprbars-button = let
    # Action Definitions
    closeAction = "hyprctl dispatch killactive";
    
    # Minimize logic: toggles window between special workspace and current active workspace
    isOnSpecial = "hyprctl activewindow -j | jq -re 'select(.workspace.name == \"special\")' >/dev/null";
    moveToSpecial = "hyprctl dispatch movetoworkspacesilent special";
    moveToActive = "hyprctl dispatch movetoworkspacesilent name:$(hyprctl -j activeworkspace | jq -re '.name')";
    minimizeAction = "${isOnSpecial} && ${moveToActive} || ${moveToSpecial}";

    maximizeAction = "hyprctl dispatch togglefloating";
  in [
    # Format: "COLOR, SIZE, ICON, COMMAND"
    # Red close button
    "rgb(f38ba8), 12, , ${closeAction}"
    # Yellow minimize button
    "rgb(f9e2af), 12, , ${minimizeAction}"
    # Green maximize button
    "rgb(a6e3a1), 12, , ${maximizeAction}"
  ];
};

    };





};

}


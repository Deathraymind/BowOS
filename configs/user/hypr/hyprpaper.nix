{}: {

services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      # If the file is named '.wallpaper.png' in your current folder:
      preload = [ "${./nixwallpaper.jpg}" ];
      
      # This applies it to all monitors using the Nix store path
      wallpaper = [ ",${./nixwallpaper.jpg}" ];
      
      splash = false;
    };
  };
}

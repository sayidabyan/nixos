{...}:
{
  home-manager.users.sayid = {...}:
  {
    services.hyprpaper = {
      settings = {
        wallpaper = [
          "eDP-1, /home/sayid/nixos/bg/Path Less Traveled.jpg"
        ];
      };
    };

    programs.waybar = {
      settings = {
        battery = {
          bat = "macsmc-battery";
        };
      };
    };

    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1, 2560x1664@60, 0x0, 2"
        ];
        
        "$mainMod" = "SUPER";
        "$mainMod2" = "ALT";
        
        render = {
          explicit_sync = 0;
          explicit_sync_kms = 0;
        };
      };
    };
  };
}

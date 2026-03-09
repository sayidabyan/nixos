{...}:
{
  home-manager.users.sayid = {...}:
  {
    services.hyprpaper = {
      settings = {
        wallpaper = [
          "eDP-1, /home/sayid/nixos/bg/path less traveled.jpg"
        ];
      };
    };
    programs.hyprpanel.settings.bar.layouts."*".right = ["systray" "media" "volume" "network" "bluetooth" "battery" "clock" "notifications"];
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1, 2560x1440@60, 0x0, 1.25"
        ];
 
        workspace = [
          "1, monitor:eDP-1, persistent:true"
          "2, monitor:eDP-1, persistent:true"
          "3, monitor:eDP-1, persistent:true"
          "4, monitor:eDP-1, persistent:true"
        ];

        "$mainMod" = "ALT";
        "$mainMod2" = "SUPER";
      };
    };
  };
}

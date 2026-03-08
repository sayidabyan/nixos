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
          "eDP-1, 1920x1080@60, 0x0, 1"
        ];

        "$mainMod" = "ALT";
        "$mainMod2" = "SUPER";
      };
    };
  };
}

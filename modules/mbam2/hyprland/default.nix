{...}:
{
  home-manager.users.sayid = {...}:
  {
    services.hyprpaper = {
      settings = {
        wallpaper = [
          "eDP-1, /home/sayid/nixos/bg/Sakura Festival.jpg"
        ];
      };
    };
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "eDP-1, 2560x1600@60, 0x0, 2"
        ];
        "$mainMod" = "SUPER";
        "$mainMod2" = "ALT";
      };
    };
  };
}
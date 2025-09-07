{...}:
{
  home-manager.users.sayid = {...}:
  {
    services.hyprpaper = {
      settings = {
        wallpaper = [
          "DP-1, /home/sayid/nixos/bg/Japan Pond.jpg"
          "DP-2, /home/sayid/nixos/bg/Japan Pond.jpg"
        ];
      };
    };
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          "DP-1, 2560x1440@144, 0x0, 1"
          "DP-2, 2560x1440@60, 2560x-583, 1, transform, 3"
        ];

        misc = {
          vrr = 1;
        };

        "$mainMod" = "ALT";
        "$mainMod2" = "SUPER";

        exec-once = [
          "xrandr --output [DP-1] --primary"
        ];
      };
    };
  };
}

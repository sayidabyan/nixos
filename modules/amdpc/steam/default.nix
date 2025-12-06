{ pkgs, ...}:
{
  # Steam
  programs.steam = {
    enable = true;
    package = pkgs.steam;
    gamescopeSession.enable = true;
    gamescopeSession.args = [
      "--prefer-output DP-1"
    ];
  };
  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope.overrideAttrs (_: {
      NIX_CFLAGS_COMPILE = ["-fno-fast-math"];
    });
  };

  home-manager.users.sayid = {...}: {
    home.sessionVariables = {
      PROTON_FSR4_UPGRADE=1;
      # PROTON_ENABLE_WAYLAND=1;
      # MANGOHUD=1;
    };
    
    xdg.desktopEntries = {
      steam-gamescope = {
        name = "Steam Gamescope";
        comment = "Launch Steam in Gamescope";
        exec = "gamescope -e -f --force-grab-cursor -h 1440 -r 144 --prefer-output=DP-1 -- steam -gamepadui";
        icon = "steam";
        type = "Application";
        terminal = false;
        categories = [ "Game" ];
      };
    };
  };
}

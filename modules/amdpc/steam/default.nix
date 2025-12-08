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
    capSysNice = true;
    args = [
      "-f"
      "--force-grab-cursor"
      "-h 1440"
      "--prefer-output DP-1"
      "--force-windows-fullscreen"
      "--adaptive-sync"
      "--rt"
      "-r 144"
    ];
    env = {
      PROTON_FSR4_UPGRADE="1";
      MANGOHUD="1";
    };
  };
  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      mangohud
      mangojuice
      protonplus
      steam-rom-manager
      heroic
    ];
    xdg.desktopEntries = {
      steam-gamescope = {
        name = "Steam Gamescope";
        comment = "Launch Steam in Gamescope";
        exec = "gamescope -- steam";
        icon = "steam";
        type = "Application";
        terminal = false;
        categories = [ "Game" ];
      };
    };
  };
}

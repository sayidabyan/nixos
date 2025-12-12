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
    package = pkgs.gamescope_git.overrideAttrs (_: {
      NIX_CFLAGS_COMPILE = ["-fno-fast-math"];
    });
    capSysNice = true;
    args = [
      "-f"
      "--force-grab-cursor"
      "-w 2560"
      "-h 1440"
      "-W 2560"
      "-H 1440"
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
  boot.extraModulePackages = [ pkgs.linuxKernel.packages.linux_6_18.zenergy ];
  programs.java = {
    enable = true;
    package = pkgs.jdk8;
  };
  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      mangohud
      mangojuice
      protonplus
      steam-rom-manager
      heroic
      prismlauncher
      unstable.rpcs3
      unstable.pcsx2
    ];
    xdg.desktopEntries = {
      steam-gamescope = {
        name = "Steam Gamescope";
        comment = "Launch Steam in Gamescope";
        exec = "gamescope -e -- steam -gamepadui";
        icon = "steam";
        type = "Application";
        terminal = false;
        categories = [ "Game" ];
      };
      minecraft = {
        name = "minecraft";
        type = "Application";
        categories = [ "Game" "ActionGame" "AdventureGame" "Simulation" ];
        exec = "/home/sayid/.nix-profile/bin/prismlauncher --launch 1.21.10";
        icon = "/home/sayid/nixos/icons/minecraft.png";
      };
    };
  };
}

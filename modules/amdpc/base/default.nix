{config, pkgs, ...}:
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    #package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    # gamescopeSession.enable = true;
  };
  home-manager.users.sayid = { pkgs, ... }: {
    xdg.desktopEntries = {
      brave-browser = {
        name = "Brave Web Browser";
        exec = "/home/sayid/.nix-profile/bin/brave --enable-features=WaylandLinuxDrmSyncobj";
        terminal = false;
        icon = "brave-browser";
      };
      vesktop = {
        name = "Vesktop";
        exec = "/home/sayid/.nix-profile/bin/vesktop --enable-features=WaylandLinuxDrmSyncobj --ozone-platform-hint=wayland";
        terminal = false;
        icon = "vesktop";
      };
    };
  };
}

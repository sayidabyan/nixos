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
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  home-manager.users.sayid = { pkgs, ... }: {
    xdg.desktopEntries = {
      brave-browser = {
        name = "Brave Web Browser";
        exec = "/home/sayid/.nix-profile/bin/brave --enable-features=WaylandLinuxDrmSyncobj";
        startupNotify = true;
        terminal = false;
        icon = "brave-browser";
        categories = ["Network" "WebBrowser"];
        mimeType = ["application/pdf" "application/rdf+xml" "application/rss+xml" "application/xhtml+xml" "application/xhtml_xml" "application/xml" "image/gif" "image/jpeg" "image/png" "image/webp" "text/html" "text/xml" "x-scheme-handler/http" "x-scheme-handler/https"];
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

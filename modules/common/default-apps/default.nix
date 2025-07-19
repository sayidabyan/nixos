{ pkgs, ...}:
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs;[
      xdg-desktop-portal-gtk
      unstable.xdg-desktop-portal-hyprland
    ];
  };
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
  
  home-manager.users.sayid = {...}:{
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
      TERMINAL = "ghostty";
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs;[
        xdg-desktop-portal-gtk
        unstable.xdg-desktop-portal-hyprland
      ];
      config.common.default = "*";
    };
    xdg.mime.enable = true;
    xdg.mimeApps = {
      enable  =  true;
      defaultApplications = {
        "x-scheme-handler/http"="zen.desktop";
        "x-scheme-handler/https"="zen.desktop";
        "x-scheme-handler/chrome"="zen.desktop";
        "text/html"="zen.desktop";
        "application/x-extension-htm"="zen.desktop";
        "application/x-extension-html"="zen.desktop";
        "application/x-extension-shtml"="zen.desktop";
        "application/xhtml+xml"="zen.desktop";
        "application/x-extension-xhtml"="zen.desktop";
        "application/x-extension-xht"="zen.desktop";
        "application/pdf" = "zen.desktop";
        "image/png" = "xviewer.desktop";
        "image/jpeg" = "xviewer.desktop";
        "image/webp" = "xviewer.desktop";
        "image/gif" = "xviewer.desktop";
        "inode/directory" = [ "nemo.desktop" ];
        "application/x-gnome-saved-search" = [ "nemo.desktop" ];
      };
      associations.added = {
        "x-scheme-handler/http"="zen.desktop";
        "x-scheme-handler/https"="zen.desktop";
        "x-scheme-handler/chrome"="zen.desktop";
        "text/html"="zen.desktop";
        "application/x-extension-htm"="zen.desktop";
        "application/x-extension-html"="zen.desktop";
        "application/x-extension-shtml"="zen.desktop";
        "application/xhtml+xml"="zen.desktop";
        "application/x-extension-xhtml"="zen.desktop";
        "application/x-extension-xht"="zen.desktop";
        "application/pdf" = "zen.desktop";
      };
    };
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}

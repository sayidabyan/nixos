{pkgs, ...}:
{
  home-manager.users.sayid = {...}: {
    programs.ghostty = {
      enable = true;
      package = pkgs.unstable.ghostty;
      enableZshIntegration = true;
      settings = {
        font-family = "Firacode Nerd Font";
        background = "#000000";
        background-opacity = 0.6;
        theme = "catppuccin-mocha";
        gtk-single-instance = true;
        quit-after-last-window-closed = false;
        resize-overlay = "never";
        confirm-close-surface = false;
      };
    };
  };
}

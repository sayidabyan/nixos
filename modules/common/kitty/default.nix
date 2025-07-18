{...}:
{
  home-manager.users.sayid = {pkgs, ...}: {
    home.file.".config/kitty/current-theme.conf" = {
      source = ./Catppuccin-Mocha.conf;
      recursive = true;
    };
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
      font.name = "Firacode Nerd Font";
      settings = {
        background = "#000000";
        background_opacity = "0.6";
        resize_debounce_time = "0";
        touch_scroll_multiplier = "10.0";
      };
      extraConfig = ''
        # BEGIN_KITTY_THEME
        include current-theme.conf
        # END_KITTY_THEME%

        # New window in current directory instead of home
        map ctrl+shift+enter launch --type=window --cwd=current
      '';
      shellIntegration.enableZshIntegration = true;
    };
  };
}

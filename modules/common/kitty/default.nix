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
        background_opacity = "0.8";
        resize_debounce_time = "0";
      };
      environment = {
        "KITTY_ENABLE_WAYLAND" = "1";
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

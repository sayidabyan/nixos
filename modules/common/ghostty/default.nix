{...}:
{
  home-manager.users.sayid = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      installVimSyntax = true;
      settings = {
        theme = "catppuccin-mocha";
        font-family = "Firacode Nerd Font";
        background-opacity = 0.8;
      };
    };
  };
}

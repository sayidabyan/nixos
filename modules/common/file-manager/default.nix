{...}:
{
#  programs.thunar = {
#    enable = true;
#    plugins = with pkgs.xfce; [
#      thunar-volman
#      thunar-archive-plugin
#      thunar-media-tags-plugin
#    ];
#  };
#  services.gvfs.enable = true;
#  services.tumbler.enable = true;
#
#  programs.xfconf.enable = true;
#  programs.file-roller.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  home-manager.users.sayid = {pkgs, ...}: {
    home.packages = with pkgs; [
      nemo-with-extensions
    ];

    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "ghostty";
      };
    };
  };
}

{...}:
{
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;
  home-manager.users.sayid = {pkgs, ...}: {
    home.packages = with pkgs; [
      nemo-with-extensions
    ];

    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "kitty";
      };
    };
  };
}

{pkgs, ...}:
{
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  programs.xfconf.enable = true;
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  home-manager.users.sayid = {pkgs, ...}: {
    home.packages = with pkgs; [
      file-roller
    ];
    home.file.".config/xfce4/helpers.rc".text = "TerminalEmulator=kitty";
  };
}

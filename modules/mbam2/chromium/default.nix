{...}:
{
  home-manager.users.sayid = {pkgs, ...}: {
    programs = {
      chromium = {
        enable = true;
        commandLineArgs = [ "--ozone-platform=wayland" ];
        package = pkgs.unstable.chromium.override { enableWideVine = true; };
      };
    };
  };
}

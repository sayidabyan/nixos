{inputs, pkgs, ...}:
{
  home-manager.users.sayid = {
    home.packages = [
      inputs.zen-browser-flake.packages.${pkgs.system}.default
    ];
  };
}

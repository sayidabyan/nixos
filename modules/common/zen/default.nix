{inputs, config, pkgs,...}:
let
  system = config.system;
in
{
  home-manager.users.sayid = {...}: {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
  };
}

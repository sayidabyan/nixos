{inputs, config, pkgs,...}:
{
  home-manager.users.sayid = {...}: {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
  };
}

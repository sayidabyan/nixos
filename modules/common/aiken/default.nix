{config, inputs, lib, pkgs, ...}:
{
  home-manager.users.sayid = {...}:
  {
    home.packages = [
      inputs.aiken.packages.${pkgs.system}.default
    ];
  };
}

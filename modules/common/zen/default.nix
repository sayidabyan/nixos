{inputs, config, ...}:
let
  system = config.system;
in
{
  home-manager.users.sayid = {...}: {
    home.packages = [
      inputs.zen-browser.packages."aarch64-linux".default
    ];
  };
}

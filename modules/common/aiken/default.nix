{config, inputs, lib, ...}:
{
  home-manager.users.sayid = {...}:
  {
    home.packages = [
      inputs.aiken.packages.aarch64-linux.default
    ];
  };
}

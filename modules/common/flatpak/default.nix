{inputs, ...}:
{
  services.flatpak = {
    enable = true;
  };
  home-manager.users.sayid = {...}:
  {
    imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
    
    services.flatpak.packages = [
      "com.github.tchx84.Flatseal"
      "io.github.celluloid_player.Celluloid"
    ];
  };
}

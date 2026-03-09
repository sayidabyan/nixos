{ pkgs, ...}:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      cider-2
      vscodium
    ];
  };
}

{...}:

{
    services.tailscale.enable = true;
    home-manager.users.sayid = {pkgs, ...}:
    {
      home.packages = [pkgs.trayscale];
    };
    networking.firewall.checkReversePath = "loose";
}

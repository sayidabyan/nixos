{...}:

{
    services.tailscale.enable = true;
    home-manager.users.sayid = {pkgs, ...}:
    {
      home.packages = [pkgs.trayscale];
    };
    networking.firewall.checkReversePath = "loose";

 #   services.zerotierone = {
 #     enable = true;
 #     port = 9994;
 #     joinNetworks = ["9e1948db638bcdb0"];
 #   };
}

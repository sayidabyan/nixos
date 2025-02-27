{ pkgs, ...}:

{
    services.tailscale = {
        enable = true;
        package = pkgs.tailscale;
    };
    networking.firewall.checkReversePath = "loose";
}

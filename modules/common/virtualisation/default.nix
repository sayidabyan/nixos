{...}:

{  
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  home-manager.users.sayid = { pkgs, ... }: {
    home.packages = with pkgs; [
      distrobox
      docker-compose
    ];
  };
}

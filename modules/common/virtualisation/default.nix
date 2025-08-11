{...}:

{
  virtualisation.containers.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  users.users.sayid = {
    extraGroups = [ "podman" ];
  };

  # virtualisation.waydroid.enable = true;
  home-manager.users.sayid = { pkgs, ... }: {
    home.packages = with pkgs; [
      distrobox
      docker-compose
      # nur.repos.ataraxiasjel.waydroid-script
    ];
  };
}

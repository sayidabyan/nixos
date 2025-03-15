{pkgs, ...}:
{
  services.jellyfin = {
    enable = true;
    dataDir = "/media/external/jellyfin";
  };

  services.nginx.virtualHosts."media.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:8096";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };
}

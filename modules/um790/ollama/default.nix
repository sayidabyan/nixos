{config, pkgs, ...}:
{
  services = {
    ollama = {
      enable = true;
      package = pkgs.unstable.ollama;
     # acceleration = "rocm";
     # environmentVariables = {
     #   HSA_OVERRIDE_GFX_VERSION="11.0.0";
     # };
    };
    open-webui = {
      enable = true;
      package = pkgs.unstable.open-webui;
      host = "100.112.119.112";
      port = 8080;
    };
  };
  services.nginx.virtualHosts."chat.say.id" = {
    locations."/" = {
      proxyPass = "http://100.112.119.112:${toString config.services.open-webui.port}";
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

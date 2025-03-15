{...}:
{
  services.seafile = {
    enable = true;
    adminEmail = "sayidabyan@proton.me";
    initialAdminPassword = "test123.";

    ccnetSettings.General.SERVICE_URL = "http://drive.say.id";
    dataDir = "/media/external/seafile";
    seafileSettings = {
      # quota.default = "500"; # Amount of GB allotted to users
      history.keep_days = "14"; # Remove deleted files after 14 days
      fileserver = {
        host = "unix:/run/seafile/server.sock";
      };
    };
  };

  services.nginx.virtualHosts."drive.say.id" = {
    locations = {
      "/" = {
        proxyPass = "http://unix:/run/seahub/gunicorn.sock";
        extraConfig = ''
          proxy_set_header   Host $host;
          proxy_set_header   X-Real-IP $remote_addr;
          proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header   X-Forwarded-Host $server_name;
          proxy_read_timeout  1200s;
          client_max_body_size 0;
        '';
      };
      "/seafhttp" = {
        proxyPass = "http://unix:/run/seafile/server.sock";
        extraConfig = ''
          rewrite ^/seafhttp(.*)$ $1 break;
          client_max_body_size 0;
          proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_connect_timeout  36000s;
          proxy_read_timeout  36000s;
          proxy_send_timeout  36000s;
          send_timeout  36000s;
        '';
      };
    };
  };
}

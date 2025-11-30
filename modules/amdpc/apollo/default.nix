{inputs, pkgs, ...}:
{
  services.sunshine = {
    enable = false;
    # package = inputs.apollo.packages.${pkgs.stdenv.hostPlatform.system}.default;
    capSysAdmin = true;
    openFirewall = true;
    applications = {
      apps = [
        {
          name = "Steam Gamescope";
          prep-cmd = [
            {
              do = "${pkgs.gamescope}/bin/gamescope -e -f -h 1440 --prefer-output=DP-1 -- ${pkgs.steam}/bin/steam -gamepadui";
            }
          ];
        }
      ];
    };
  };
}

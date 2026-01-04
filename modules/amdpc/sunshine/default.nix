{
  pkgs,
  ...
}:
{
  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
    applications = {
      env = {
        "PATH" = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Steam Big Picture";
          prep-cmd = [
            {
              do = "";
              undo = "pkill -9 gamescope";
            }
          ];
          detached = [
            "${pkgs.gamescope}/bin/gamescope -e -f -h 1440 --prefer-output=DP-1 -- steam -gamepadui"
          ];
          image-path = "steam.png";
        }
      ];
    };
  };
}

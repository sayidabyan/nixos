{inputs, ...}:
{
  home-manager.users.sayid = {pkgs, ...}:{
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
      pkgs.ffmpeg
    ];
  };
}

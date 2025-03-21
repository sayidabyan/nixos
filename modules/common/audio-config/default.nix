{ lib, pkgs, ... }:

{
  security.rtkit.enable = true;

  # Disable Pulseaudio because Pipewire is used.
  hardware.pulseaudio.enable = lib.mkForce false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true;
      package = pkgs.wireplumber;
    };
  };
  home-manager.users.sayid = { pkgs, ... }: {
    home.packages = with pkgs; [
      pavucontrol
    ];
  };
}
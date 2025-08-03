{config, pkgs, ...}:
{
  # Steam
  programs.steam = {
    enable = true;
    package = pkgs.unstable.steam;
  };

  boot.kernelParams = [ 
    "amdgpu.ppfeaturemask=0xffffffff" # enable radeon oc control(?)
    # fix nic/ethernet issue (?)
    "pcie_port_pm=off"
    "pcie_aspm.policy=performance"
  ];

  # Mostly Radeon Related
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs.mesa_git;
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  home-manager.users.sayid = {...}: {
    home.packages = with pkgs; [
      unstable.lact
      mangohud
      unstable.protonplus
      steam-rom-manager
      unigine-heaven
      unigine-superposition
    ];
  };
  systemd.services.lactd = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.unstable.lact}/bin/lact daemon";
    };
    enable = true;
  };

  # udev rules for dualsense
  services.udev.extraRules = ''
    # PS5 DualSense controller over USB hidraw
    ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
  hardware.enableAllFirmware = true;

  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    acceleration = "rocm";
    host = "0.0.0.0";
  };
  services.nginx.virtualHosts."ollama.say.id" = {
    locations."/" = {
      proxyPass = "http://100.72.251.119:11434";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 10000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };
}
